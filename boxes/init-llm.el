;; -*- lexical-binding: t; -*-

(defmacro define-llm-model (name)
  `(make-llm-ollama
	   ;; this model should be pulled to use it
	   ;; value should be the same as you print in terminal during pull
	   :host "192.168.50.231"
	   :chat-model ,name
	   :embedding-model ,name))

(use-package ellama
  :init
  ;; setup key bindings
  (setopt ellama-keymap-prefix "C-c e")
  ;; language you want ellama to translate to
  (setopt ellama-language "Chinese")
  ;; could be llm-openai for example
  (require 'llm-ollama)
  (setopt ellama-provider
	  (define-llm-model "mistral:7b-instruct-v0.2-q4_0")
	  )
  ;; Predefined llm providers for interactive switching.
  ;; You shouldn't add ollama providers here - it can be selected interactively
  ;; without it. It is just example.
  (setopt ellama-providers
	  '(("llama3" . (define-llm-model "llama3"))
	    ))
  ;; Naming new sessions with llm
  (setopt ellama-naming-provider
	  (define-llm-model "llama3"))
  (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
  ;; Translation llm provider
  (setopt ellama-translation-provider (define-llm-model "llama3")))

(use-package gptel)

;; Groq offers an OpenAI compatible API
(gptel-make-openai "Groq"               ;Any name you want
  :host "api.groq.com"
  :endpoint "/openai/v1/chat/completions"
  :stream t
  :key "your-api-key"                   ;can be a function that returns the key
  :models '(
            "llama3-70b-8192"))
