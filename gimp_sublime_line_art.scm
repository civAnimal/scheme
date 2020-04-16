;; civAnimal ... 2020
;;
;; A free GIMP plugin/filter to turn your photos into a beautiful line-art (with hints of subtle colors).
;;
;; Just copy this plugin in your scripts folder.
;; The filter shall be available under Filters > Artistic > Sublime-Line-Art
;; .. Enjoy!
;;
;; Note:
;; This filter can be applied to a single layer.
;; It does not work with selections. Any active selection shall be discarded by this filter.

(define (gimp-sublime-line-art img drw)
  (let*
    (
      (lyr (car (gimp-layer-copy drw FALSE)))
      (width (car (gimp-drawable-width drw)))
      (height (car (gimp-drawable-height drw)))
      (type (car (gimp-drawable-type drw)))
      (white (car (gimp-layer-new img width height type "white" 100.0 LAYER-MODE-GRAIN-MERGE)))
      (gray (car (gimp-layer-new img width height type "gray" 100.0 LAYER-MODE-COLOR-ERASE)))
      (final 0)
    )
    (gimp-image-undo-group-start img)
    (gimp-context-push)
    (gimp-image-freeze-layers img)
    (gimp-selection-none img)
    (gimp-image-insert-layer img lyr 0 -1)
    (gimp-drawable-invert lyr FALSE)
    (plug-in-gauss-iir RUN-NONINTERACTIVE img lyr 10.0 TRUE TRUE)
    (gimp-layer-set-mode lyr LAYER-MODE-DODGE)
    (set! lyr (car (gimp-image-merge-down img lyr CLIP-TO-BOTTOM-LAYER)))
    (gimp-drawable-invert lyr FALSE)
    (gimp-drawable-fill white FILL-WHITE)
    (gimp-image-insert-layer img white 0 -1)
    (set! lyr (car (gimp-image-merge-down img white CLIP-TO-BOTTOM-LAYER)))
    (gimp-context-set-foreground '(127.50 127.50 127.50))
    (gimp-drawable-fill gray FILL-FOREGROUND)
    (gimp-image-insert-layer img gray 0 -1)
    (set! lyr (car (gimp-image-merge-down img gray CLIP-TO-BOTTOM-LAYER)))
    (gimp-drawable-invert lyr FALSE)
    (set! final (car (gimp-layer-copy lyr FALSE)))
    (plug-in-gauss-iir RUN-NONINTERACTIVE img lyr 20.0 TRUE TRUE)
    (gimp-image-insert-layer img final 0 -1)
    (gimp-image-merge-down img final CLIP-TO-BOTTOM-LAYER)
    (letrec
      (
        (proc
          (lambda (c bg)
            (unless (null? c)
              (gimp-context-set-foreground (car c))
              (gimp-drawable-fill bg FILL-FOREGROUND)
              (gimp-image-insert-layer img bg 0 -1)
              (gimp-image-lower-item img bg)
              (proc (cdr c) (car (gimp-layer-copy bg FALSE)))
            )
          )
        )
      )
        (proc  '( (127.5 122.4 153.0) (124.3 127.5 114.8) (153 137.7 122.4) )
                (car (gimp-layer-new img width height type "bg" 100.0 LAYER-MODE-NORMAL)))
    )
  )
  (gimp-image-undo-group-end img)
  (gimp-displays-flush)
  (gimp-image-thaw-layers img)
  (gimp-context-pop)
)

(script-fu-register
  "gimp-sublime-line-art"
  "Sublime-Line-Art"
  "Turn your photos into a sublime line-art, with hints of subtle colors."
  "civAnimal"
  "civAnimal"
  "2020"
  "RGB* GRAY*"
  SF-IMAGE      "Image"     0
  SF-DRAWABLE   "Drawable"  0
)

(script-fu-menu-register "gimp-sublime-line-art" "<Image>/Filters/Artistic")

;; How to get the location of scripts folder in GIMP:
;;
;; ... Go to Edit > Preferences > Folders > Scripts
;; ... On Windows PC it looks something like this ... C:\Users\???\AppData\Roaming\GIMP\2.10\scripts
