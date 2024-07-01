(require-builtin steel/random as rand::)
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

(define rng (rand::thread-rng!))

;; Picking one from the possible themes
(define possible-themes '("ayu_mirage" "tokyonight_storm" "catppuccin_macchiato"))

(define (select-random lst)
  (let ([index (rand::rng->gen-range rng 0 (length lst))]) (list-ref lst index)))

(define (randomly-pick-theme options)
  ;; Randomly select the theme from the possible themes list
  (helix.theme *helix.cx* (list (select-random options)) helix.PromptEvent::Validate))

(randomly-pick-theme possible-themes)

