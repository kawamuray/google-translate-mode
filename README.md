What is this?
=============
Emacs minor mode for displaying translated text using Google Translate in real time.

Installation
============

Prerequirement
--------------
This package requires [google-translate.el](https://github.com/manzyuk/google-translate) as it's backend.
Please install it first if you haven't installed yet.

Configure .emacs
----------------
Make sure that 'google-translate-mode.el' is placed in correct location which included in load-path.
Add following lines to your .emacs file.

```el
(require 'google-translate-mode)
```

You can customize time to wait before execute translate from when idle state has began.

```el
(custom-set-variables '(google-translate-mode-idle-wait-time 0.2))
```

Usage
=====
Just enable google-translate-mode in buffer you want to translate.

    M-x google-translate-mode RET
