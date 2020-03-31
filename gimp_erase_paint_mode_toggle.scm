;; civAnimal ... 2020
;;
;; A free plugin to quickly and easily toggle between Erase and Normal paint modes in GIMP.
;;
;; 1. Copy this plugin in your scripts folder.
;; 2. Add a shortcut key to this plugin.
;; .. Enjoy!

(define gimp-erase-paint-mode-toggle
  (lambda ()
    (if (= (car (gimp-context-get-paint-mode)) LAYER-MODE-ERASE)
      (gimp-context-set-paint-mode LAYER-MODE-NORMAL)
      (gimp-context-set-paint-mode LAYER-MODE-ERASE)
    )
  )
)

(script-fu-register "gimp-erase-paint-mode-toggle"
  "Paint_Mode: Erase/Normal (Toggle)"
  "Toggle between Normal and Erase paint modes."
  "civAnimal"
  "civAnimal"
  "2020"
  "RGB* GRAY*"
)

(script-fu-menu-register "gimp-erase-paint-mode-toggle"
                         "<Image>/Script-Fu")

;; How to get the location of scripts folder in GIMP:
;;
;; ... Go to Edit > Preferences > Folders > Scripts
;; ... On Windows PC it looks something like this ... C:\Users\???\AppData\Roaming\GIMP\2.10\scripts

;; How to add a shortcut key in GIMP:
;;
;; ... Go to Edit > Keyboard Shortcuts
;; ... Search > PaintMode: Erase
;; ... Click > Paint_Mode: Erase/Normal (Toggle)
;; ... Type desired key
;; ... Click > Save
;; ... Click > Close
