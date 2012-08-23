(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(global-set-key "\C-h" 'delete-backward-char)

(defun linux-c-mode ()
"C mode with adjusted defaults for use with the Linux kernel."
(interactive)
(c-mode)
(c-set-style "K&R")
(setq tab-width 8)
(setq indent-tabs-mode t)
(setq c-basic-offset 8))

(setq auto-mode-alist (cons '("/home/jin/devel/kernel/linux.*/.*\\.[ch]$" . linux-c-mode)
auto-mode-alist))


(add-to-list 'load-path "/home/jin/lib/twittering-mode")
;(add-to-list 'load-path "/home/jin/lib/twittering-mode-2.0.0")
;(setq twittering-use-master-password t)

(require 'twittering-mode)
;(setq twittering-allow-insecure-server-cert t)
(setq twittering-initial-timeline-spec-string
      '(":home"
        ":mentions"
        ":replies"
        ":favorites"
        "nakj/tech"))

(add-hook 'twittering-mode-hook
          (lambda ()
            (set-face-bold-p 'twittering-username-face t)
            (set-face-foreground 'twittering-username-face "gray60")
            (set-face-foreground 'twittering-uri-face "gray60")
                (setq twittering-status-format "%i %p%s \n%FOLD{%T}\n%r %R [%@]")
                    (setq twittering-retweet-format " RT @%s: %t")
            ;; "F"でお気に入り
            ;; "R"でリツイートできるようにする
            (define-key twittering-mode-map (kbd "F") 'twittering-favorite)
            (define-key twittering-mode-map (kbd "R") 'twittering-native-retweet)

            ;; "<"">"で先頭、最後尾にいけるように
            (define-key twittering-mode-map (kbd "<") (lambda () (interactive) (goto-char (point-min))))
            (define-key twittering-mode-map (kbd ">") (lambda () (interactive) (goto-char (point-max)))
)))


;;;;mew

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
;; Optional setup (Read Mail menu):
(setq read-mail-command 'mew)


(setq mew-use-cached-passwd t)
;; Optional setup (e.g. C-xm for sending a message):
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

(setq mew-proto "%")

(setq mew-imap-server "127.0.0.1")
(setq mew-imap-auth nil)
(setq mew-imap-ssl nil)
(setq mew-imap-delete nil)
(setq mew-imap-port "143")

;;;;w3m
(require 'w3m-load)
(setq w3m-use-cookies t)
(setq browse-url-browser-function 'w3m-browse-url)

