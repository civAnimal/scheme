; A free plugin to quickly and easily toggle between <Erase> and <Normal> paint modes in GIMP.
;
; Installation:
;
; 1. Copy this plugin in your scripts folder.
; 2. Add a shortcut key to this plugin (Recommended shortcut key: E).
; .. Enjoy!

(define (gimp-erase-paint-mode-toggle)
  (if (= LAYER-MODE-ERASE (car (gimp-context-get-paint-mode)))
    (gimp-context-set-paint-mode LAYER-MODE-NORMAL)
    (gimp-context-set-paint-mode LAYER-MODE-ERASE)
  )
)

(script-fu-register "gimp-erase-paint-mode-toggle"
  "Paint-Mode: _Erase/Normal (Toggle)"
  "Toggle between Normal and Erase paint modes."
  "civAnimal"
  "civAnimal"
  "2020"
  "*"
)

(script-fu-menu-register "gimp-erase-paint-mode-toggle" "<Image>/Filters/Languages/Script-Fu")

; Tips:
;
; How to get the location of scripts folder in GIMP:
;
; ... Go to Edit > Preferences > Folders > Scripts
; ... On Windows PC it looks something like this ... C:\Users\???\AppData\Roaming\GIMP\2.10\scripts
;
; How to add a shortcut key in GIMP:
;
; ... Go to Edit > Keyboard Shortcuts
; ... Search > PaintMode: Erase
; ... Click > Paint_Mode: Erase/Normal (Toggle)
; ... Type desired key ... (Recommended shortcut key: E)
; ... Click > Save
; ... Click > Close

; Copyright (c) 2020 civAnimal ... Email: civanimal@gmail.com ... Twitter: civAnimal
