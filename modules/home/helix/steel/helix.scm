(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

(provide shell git-add open-helix-scm open-init-scm reload-helix-scm)

;;@doc
;; Specialized shell implementation, where % is a wildcard for the current file
(define (shell cx . args)
  ;; Replace the % with the current file
  (define expanded (map (lambda (x) (if (equal? x "%") (current-path cx) x)) args))
  (helix.run-shell-command cx expanded helix.PromptEvent::Validate))

;;@doc
;; Adds the current file to git
(define (git-add cx)
  (shell cx "git" "add" "%"))

;; Functions to assist with the above

(define (editor-get-doc-if-exists editor doc-id)
  (if (editor-doc-exists? editor doc-id) (editor->get-document editor doc-id) #f))

(define (current-path cx)
  (let* ([editor (cx-editor! cx)]
         [focus (editor-focus editor)]
         [focus-doc-id (editor->doc-id editor focus)]
         [document (editor-get-doc-if-exists editor focus-doc-id)])

    (if document (Document-path document) #f)))

;;@doc
;; Reload the helix.scm file
(define (reload-helix-scm cx)
  (helix.static.run-in-engine! cx
    (string-append "(require \"" (helix.static.get-helix-scm-path) "\")")))

;;@doc
;; Open the helix.scm file
(define (open-helix-scm cx)
  (helix.open cx (list (helix.static.get-helix-scm-path)) helix.PromptEvent::Validate))

;;@doc
;; Opens the init.scm file
(define (open-init-scm cx)
  (helix.open cx (list (helix.static.get-init-scm-path)) helix.PromptEvent::Validate))
