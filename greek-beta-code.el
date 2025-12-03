;;; greek-beta-code.el --- Quail package for inputting polytonic Greek -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C) 2025- Domenico Cufalo <cufalo at gmail dot com>

;; Author: Domenico Cufalo <cufalo at gmail dot com>
;; Version: 1.0.0
;; Created: 22 Nov 2025
;; Package-Requires: ((emacs "24"))
;; Keywords: i18n, multilingual, input method, greek
;; URL: https://framagit.org/Doc73/polytonicgreek-doc

;; Based on the work of Johannes Choo:
;; https://github.com/jhanschoo/greek-polytonic

;;; Commentary:

;; This package provides a method for inputting polytonic Greek, 
;; based on Beta Code, but with small additions.
;;
;; About Beta Code, see https://en.wikipedia.org/wiki/Beta_Code
;;
;; These are the relevant Unicode Charts:
;; - http://unicode.org/charts/PDF/U0370.pdf Greek and Coptic
;; - http://unicode.org/charts/PDF/U1F00.pdf Greek Extended
;;
;; Where Unicode specifies a NFC for characters in the above tables,
;; we use the normalized forms instead.
;;
;; Where a decomposed sequence of letters and combining diacritics is
;; necessary, we use the following sequence, modeling the canonical
;; Unicode decomposition of procomposed characters where available,
;; and from closest to furthest where unavailable:
;;
;; <letter>-<length>-<diaeresis>-<breathing>-<accent>-<ypogegrammeni>
;;
;; For convenience, we list here all the combining diacritics that
;; this input method inputs, or that a precomposed character that this
;; input method inputs decomposes into.
;;
;; <length>:
;; U+0304 COMBINING MACRON
;; U+0306 COMBINING BREVE
;;
;; <diaeresis>:
;; U+0308 COMBINING DIAERESIS
;;
;; <breathing>:
;; U+0313 COMBINING COMMA ABOVE
;; U+0314 COMBINING REVERSED COMMA ABOVE
;; U+0308 COMBINING DIAERESIS
;;
;; <accent>:
;; U+0301 COMBINING ACUTE ACCENT
;; U+0300 COMBINING GRAVE ACCENT
;; U+0342 COMBINING GREEK PERISPOMENI
;;
;; <ypogegrammeni>:
;; U+0345 COMBINING GREEK YPOGEGRAMMENI
;;
;; Relevant known naming defects in Unicode names in the two blocks:
;; U+039B is CAPITAL LAMDA
;; where CAPITAL LAMBDA might be expected.
;; U+03BB is SMALL LAMDA
;; where SMALL LAMBDA might be expected.
;;

;;; Code:

(require 'quail)

(quail-define-package
	"greek-beta-code" ; package name
	"Classical Greek" ; input
    "β+" ; modeline indicator
    t ; show what keys you can press, like which-key
    "A polytonic Greek layout based on Beta Code Greek layout with some
additions to easily write UTF-8 encoded polytonic Greek characters for
use in Classical Philology.

Diacrytics must be written *after* vowels according the following order:

<letter>-<length>-<diaeresis>-<breathing>-<accent>-<ypogegrammeni>

Unicode offers precomposed vowel plus macron and breve
combinations for the plain vowels α, ι, and υ (ᾱ, ῑ, ῡ) but makes
no provision for such vowels with breathings and/or accents.
I added here these glyphs with vowel lenght and other diacritics, 
but in this case it will be necessary to use combining diacritics: 
not all the fonts are designed for this and not all word processors or 
page composition apps support combining marks, so be careful!

This layout provide also two additional keys:
- the | key written *before* the correspondig letter produces arcaic 
greek characters;
- an \\ escape character written *before* a key produces the normal key
of keyboard in use.

----------------------------------------
mark                  key	keyalt
----------------------------------------
iota subscript         |
rough breath           (
smooth breath          )
acute                  /
grave                  \\
circumflex             =
diaresis               +
macron                 &
breve                  '
middle dot (·)         :
semicolon (;)          ;
colon (:)              \\:
keraia (ʹ)           AltGr+n
ar. keraia (͵)       AltGr+N
left parenth.          ((
right parenth          ))
left sing. quot. (‘)   [[	AltGr+V
right sing. quot. (’)  ]]	AltGr+B
left doub. quot. (“)   {{	AltGr+v
right doub. quot. (”)  }}	AltGr+b
left doub. ang. («)    |\\	AltGr+<
right doub. ang. (»)   ||	AltGr+>
----------------------------------------

----------------------------------------
character     capital         small
----------------------------------------
alpha           A               a
beta            B               b
gamma           G               g
delta           D               d
epsilon         E               e
zeta            Z               z
eta             H               h
theta           Q               q
iota            I               i
kappa           K               k
lamda           L               l
mu              M               m
nu              N               n
xi              C               c
omicron         O               o
pi              P               p
rho             R               r
sigma           S               s
final sigma                     j
tau             T               t
upsilon         U               u
phi             F               f
chi             X               x
psi             Y               y
omega           W               w
----------------------------------------
digamma         V               v
koppa arc.     |P              |p
koppa mod.     |K              |k
stigma         |J              |j
sampi          |S              |s
kappa symbol   |x
rho symbol     |r
lunate sigma   |c
----------------------------------------" ; docstring
    nil ; no additional translation keys
    t ; remember previous translations of a key
    nil ; if there's more than one translation for keys, let the user choose
    nil ; don't translate user's keyboard to standard layout
    nil ; don't need a visual diagram of keyboard in helptext
    nil ; don't need decode map (table from translations back to keys)
    nil ; don't break key sequences at shortest sequence
    nil ; no overlay
    nil ; use standard function to insert translated characters
    nil ; no additional conversion keys
    t) ; keep bindings like C-f and C-b the same as standard

(quail-define-rules

  ;; Combining diacritical marks
  ("/" ?́) ; U+0301 COMBINING ACUTE ACCENT
  ("\\" ?̀); U+0300 COMBINING GRAVE ACCENT
  ("=" ?͂) ; U+0342 COMBINING GREEK PERISPOMENI
  (")" ?̓) ; U+0313 COMBINING COMMA ABOVE
  ("(" ?̔) ; U+0314 COMBINING REVERSED COMMA ABOVE
  ("|" ?ͅ) ; U+0345 COMBINING GREEK YPOGEGRAMMENI
  ("&" ?̄) ; U+0304 COMBINING MACRON
  ("'" ?̆) ; U+0306 COMBINING BREVE
  ("+" ?̈) ; U+0308 COMBINING DIAERESIS
  
  ;; punctuation
  ("," ?,)		; U+002C COMMA
  ("." ?.)		; U+002E FULL STOP
  (";" ?;)		; U+003B SEMICOLON (QUESTION MARK)
  (":" ?·)  	; U+00B7 MIDDLE DOT
  ("((" ?\()	; U+0028 LEFT PARENTHESIS
  ("))" ?\))	; U+0029 RIGHT PARENTHESIS
  ("[[" ?‘)		; U+2018 LEFT SINGLE QUOTATION MARK
  ("]]" ?’)		; U+2019 RIGHT SINGLE QUOTATION MARK
  ("{{" ?“)		; U+201C LEFT DOUBLE QUOTATION MARK
  ("}}" ?”)		; U+201D RIGHT DOUBLE QUOTATION MARK
  ("ñ" ?ʹ)		; U+0374 GREEK NUMERAL SIGN (DEXIA KERAIA)
  ("Ñ" ?͵)		; U+0375 GREEK LOWER NUMERAL SIGN (ARISTERI KERAIA)

  ;; lowercase keyboard
  ("1" ?1)
  ("2" ?2)
  ("3" ?3)
  ("4" ?4)
  ("5" ?5)
  ("6" ?6)
  ("7" ?7)
  ("8" ?8)
  ("9" ?9)
  ("0" ?0)
  ("`" ?`)
  ("j" ?ς) ; U+03C2 SMALL FINAL SIGMA
  ("e" ?ε) ; U+03B5 SMALL EPSILON
  ("r" ?ρ) ; U+03C1 SMALL RHO
  ("t" ?τ) ; U+03C4 SMALL TAU
  ("u" ?υ) ; U+03C5 SMALL UPSILON
  ("q" ?θ) ; U+03B8 SMALL THETA
  ("i" ?ι) ; U+03B9 SMALL IOTA
  ("o" ?ο) ; U+03BF SMALL OMICRON
  ("p" ?π) ; U+03C0 SMALL PI
  ("a" ?α) ; U+03B1 SMALL ALPHA
  ("s" ?σ) ; U+03C3 SMALL SIGMA
  ("d" ?δ) ; U+03B4 SMALL DELTA
  ("f" ?φ) ; U+03C6 SMALL PHI
  ("g" ?γ) ; U+03B3 SMALL GAMMA
  ("h" ?η) ; U+03B7 SMALL ETA
  ("c" ?ξ) ; U+03BE SMALL XI
  ("k" ?κ) ; U+03BA SMALL KAPPA
  ("l" ?λ) ; U+03BB SMALL LAMDA
  ("z" ?ζ) ; U+03B6 SMALL ZETA
  ("x" ?χ) ; U+03C7 SMALL CHI
  ("y" ?ψ) ; U+03C8 SMALL PSI
  ("w" ?ω) ; U+03C9 SMALL OMEGA
  ("b" ?β) ; U+03B2 SMALL BETA
  ("n" ?ν) ; U+03BD SMALL NU
  ("m" ?μ) ; U+03BC SMALL MU

  ; Final sigma
  ("s " ["ς "]) ; FINAL SIGMA WITH SPACE
  ("s," ["ς,"]) ; FINAL SIGMA WITH COMMA
  ("s." ["ς."]) ; FINAL SIGMA WITH DOT
  ("s:" ["ς·"]) ; FINAL SIGMA WITH MIDDLE DOT (COLON)
  ("s;" ["ς;"]) ; FINAL SIGMA WITH SEMICOLON
  ("s)" ["ς)"]) ; FINAL SIGMA WITH PARENTHESIS

  ;; uppercase keyboard
  ("!" ?!)
  ("@" ?@)
  ("$" ?$)
  ("%" ?%)
  ("^" ?^)
  ("*" ?*)
  ("~" ?~)
  ("E" ?Ε) ; U+0395 CAPITAL EPSILON
  ("R" ?Ρ) ; U+03A1 CAPITAL RHO
  ("T" ?Τ) ; U+03A4 CAPITAL TAU
  ("U" ?Υ) ; U+03A5 CAPITAL UPSILON
  ("Q" ?Θ) ; U+0398 CAPITAL THETA
  ("I" ?Ι) ; U+0399 CAPITAL IOTA
  ("O" ?Ο) ; U+039F CAPITAL OMICRON
  ("P" ?Π) ; U+03A0 CAPITAL PI
  ("A" ?Α) ; U+0391 CAPITAL ALPHA
  ("S" ?Σ) ; U+03A3 CAPITAL SIGMA
  ("D" ?Δ) ; U+0394 CAPITAL DELTA
  ("F" ?Φ) ; U+03A6 CAPITAL PHI
  ("G" ?Γ) ; U+0393 CAPITAL GAMMA
  ("H" ?Η) ; U+0397 CAPITAL ETA
  ("C" ?Ξ) ; U+039E CAPITAL XI
  ("K" ?Κ) ; U+039A CAPITAL KAPPA
  ("L" ?Λ) ; U+039B CAPITAL LAMDA
  ("Z" ?Ζ) ; U+0396 CAPITAL ZETA
  ("X" ?Χ) ; U+03A7 CAPITAL CHI
  ("Y" ?Ψ) ; U+03A8 CAPITAL PSI
  ("W" ?Ω) ; U+03A9 CAPITAL OMEGA
  ("B" ?Β) ; U+0392 CAPITAL BETA
  ("N" ?Ν) ; U+039D CAPITAL NU
  ("M" ?Μ) ; U+039C CAPITAL MU
  ("<" ?<)
  (">" ?>)
  ("?" ??)
  
  ;; Archaic letters
  ("|P" ?Ϙ) ; U+03D8 CAPITAL ARCHAIC KOPPA
  ("|p" ?ϙ) ; U+03D9 SMALL ARCHAIC KOPPA
  ("|J" ?Ϛ) ; U+03DA CAPITAL STIGMA
  ("|j" ?ϛ) ; U+03DB SMALL STIGMA
  ("V" ?Ϝ)  ; U+03DC CAPITAL DIGAMMA
  ("v" ?ϝ)  ; U+03DD SMALL DIGAMMA
  ("|K" ?Ϟ) ; U+03DE CAPITAL KOPPA
  ("|k" ?ϟ) ; U+03DF SMALL KOPPA
  ("|S" ?Ϡ) ; U+03E0 CAPITAL SAMPI
  ("|s" ?ϡ) ; U+03E1 SMALL SAMPI
  
  ;; Variant letterforms
  ("|x" ?ϰ) ; 03F0 KAPPA SYMBOL
  ("|r" ?ϱ) ; 03F1 RHO SYMBOL
  ("|c" ?ϲ) ; 03F2 LUNATE SIGMA SYMBOL

  ;; precomposed monotonic greek letters
  ("A/" ?Ά) ; U+0386 CAPITAL ALPHA WITH TONOS ≡ 0391 0301
  ("E/" ?Έ) ; U+0388 CAPITAL EPSILON WITH TONOS ≡ 0395 0301
  ("H/" ?Ή) ; U+0389 CAPITAL ETA WITH TONOS ≡ 0397 0301
  ("I/" ?Ί) ; U+038A CAPITAL IOTA WITH TONOS ≡ 0399 0301
  ("O/" ?Ό) ; U+038C CAPITAL OMICRON WITH TONOS ≡ 039F 0301
  ("U/" ?Ύ) ; U+038E CAPITAL UPSILON WITH TONOS ≡ 03A5 0301
  ("W/" ?Ώ) ; U+038F CAPITAL OMEGA WITH TONOS ≡ 03A9 0301
  ("i+/" ?ΐ); U+0390 SMALL IOTA WITH DIALYTIKA AND TONOS ≡ 03B9 0308 0301
  ("I+" ?Ϊ) ; U+03AA CAPITAL IOTA WITH DIALYTIKA ≡ 0399 0308
  ("U+" ?Ϋ) ; U+03AB CAPITAL UPSILON WITH DIALYTIKA ≡ 03A5 0308
  ("a/" ?ά) ; U+03AC SMALL ALPHA WITH TONOS ≡ 03B1 0301
  ("e/" ?έ) ; U+03AD SMALL EPSILON WITH TONOS ≡ 03B5 0301
  ("h/" ?ή) ; U+03AE SMALL ETA WITH TONOS ≡ 03B7 0301
  ("i/" ?ί) ; U+03AF SMALL IOTA WITH TONOS ≡ 03B9 0301
  ("u+/" ?ΰ); U+03B0 SMALL UPSILON WITH DIALYTIKA AND TONOS ≡ 03CB 0301
  ("i+" ?ϊ) ; U+03CA SMALL IOTA WITH DIALYTIKA ≡ 03B9 0308
  ("u+" ?ϋ) ; U+03CB SMALL UPSILON WITH DIALYTIKA ≡ 03C5 0308
  ("o/" ?ό) ; U+03CC SMALL OMICRON WITH TONOS ≡ 03BF 0301
  ("u/" ?ύ) ; U+03CD SMALL UPSILON WITH TONOS ≡ 03C5 0301
  ("w/" ?ώ) ; U+03CE SMALL OMEGA WITH TONOS ≡ 03C9 0301

  ;; precomposed polytonic greek letters
  ("a)" ?ἀ) ; U+1F00 SMALL ALPHA WITH PSILI ≡
  ("a(" ?ἁ) ; U+1F01 SMALL ALPHA WITH DASIA ≡
  ("a)\\" ?ἂ) ; U+1F02 SMALL ALPHA WITH PSILI AND VARIA ≡
  ("a(\\" ?ἃ) ; U+1F03 SMALL ALPHA WITH DASIA AND VARIA ≡
  ("a)/" ?ἄ) ; U+1F04 SMALL ALPHA WITH PSILI AND OXIA ≡
  ("a(/" ?ἅ) ; U+1F05 SMALL ALPHA WITH DASIA AND OXIA ≡
  ("a)=" ?ἆ) ; U+1F06 SMALL ALPHA WITH PSILI AND PERISPOMENI ≡
  ("a(=" ?ἇ) ; U+1F07 SMALL ALPHA WITH DASIA AND PERISPOMENI ≡
  ("A)" ?Ἀ) ; U+1F08 CAPITAL ALPHA WITH PSILI ≡
  ("A(" ?Ἁ) ; U+1F09 CAPITAL ALPHA WITH DASIA ≡
  ("A)\\" ?Ἂ) ; U+1F0A CAPITAL ALPHA WITH PSILI AND VARIA ≡
  ("A(\\" ?Ἃ) ; U+1F0B CAPITAL ALPHA WITH DASIA AND VARIA ≡
  ("A)/" ?Ἄ) ; U+1F0C CAPITAL ALPHA WITH PSILI AND OXIA ≡
  ("A(/" ?Ἅ) ; U+1F0D CAPITAL ALPHA WITH DASIA AND OXIA ≡
  ("A)=" ?Ἆ) ; U+1F0E CAPITAL ALPHA WITH PSILI AND PERISPOMENI ≡
  ("A(=" ?Ἇ) ; U+1F0F CAPITAL ALPHA WITH DASIA AND PERISPOMENI ≡
  ("e)" ?ἐ) ; U+1F10 SMALL EPSILON WITH PSILI ≡
  ("e(" ?ἑ) ; U+1F11 SMALL EPSILON WITH DASIA ≡
  ("e)\\" ?ἒ) ; U+1F12 SMALL EPSILON WITH PSILI AND VARIA ≡
  ("e(\\" ?ἓ) ; U+1F13 SMALL EPSILON WITH DASIA AND VARIA ≡
  ("e)/" ?ἔ) ; U+1F14 SMALL EPSILON WITH PSILI AND OXIA ≡
  ("e(/" ?ἕ) ; U+1F15 SMALL EPSILON WITH DASIA AND OXIA ≡
  ("E)" ?Ἐ) ; U+1F18 CAPITAL EPSILON WITH PSILI ≡
  ("E(" ?Ἑ) ; U+1F19 CAPITAL EPSILON WITH DASIA ≡
  ("E)\\" ?Ἒ) ; U+1F1A CAPITAL EPSILON WITH PSILI AND VARIA ≡
  ("E(\\" ?Ἓ) ; U+1F1B CAPITAL EPSILON WITH DASIA AND VARIA ≡
  ("E)/" ?Ἔ) ; U+1F1C CAPITAL EPSILON WITH PSILI AND OXIA ≡
  ("E(/" ?Ἕ) ; U+1F1D CAPITAL EPSILON WITH DASIA AND OXIA ≡
  ("h)" ?ἠ) ; U+1F20 SMALL ETA WITH PSILI ≡
  ("h(" ?ἡ) ; U+1F21 SMALL ETA WITH DASIA ≡
  ("h)\\" ?ἢ) ; U+1F22 SMALL ETA WITH PSILI AND VARIA ≡
  ("h(\\" ?ἣ) ; U+1F23 SMALL ETA WITH DASIA AND VARIA ≡
  ("h)/" ?ἤ) ; U+1F24 SMALL ETA WITH PSILI AND OXIA ≡
  ("h(/" ?ἥ) ; U+1F25 SMALL ETA WITH DASIA AND OXIA ≡
  ("h)=" ?ἦ) ; U+1F26 SMALL ETA WITH PSILI AND PERISPOMENI ≡
  ("h(=" ?ἧ) ; U+1F27 SMALL ETA WITH DASIA AND PERISPOMENI ≡
  ("H)" ?Ἠ) ; U+1F28 CAPITAL ETA WITH PSILI ≡
  ("H(" ?Ἡ) ; U+1F29 CAPITAL ETA WITH DASIA ≡
  ("H)\\" ?Ἢ) ; U+1F2A CAPITAL ETA WITH PSILI AND VARIA ≡
  ("H(\\" ?Ἣ) ; U+1F2B CAPITAL ETA WITH DASIA AND VARIA ≡
  ("H)/" ?Ἤ) ; U+1F2C CAPITAL ETA WITH PSILI AND OXIA ≡
  ("H(/" ?Ἥ) ; U+1F2D CAPITAL ETA WITH DASIA AND OXIA ≡
  ("H)=" ?Ἦ) ; U+1F2E CAPITAL ETA WITH PSILI AND PERISPOMENI ≡
  ("H(=" ?Ἧ) ; U+1F2F CAPITAL ETA WITH DASIA AND PERISPOMENI ≡
  ("i)" ?ἰ) ; U+1F30 SMALL IOTA WITH PSILI ≡
  ("i(" ?ἱ) ; U+1F31 SMALL IOTA WITH DASIA ≡
  ("i)\\" ?ἲ) ; U+1F32 SMALL IOTA WITH PSILI AND VARIA ≡
  ("i(\\" ?ἳ) ; U+1F33 SMALL IOTA WITH DASIA AND VARIA ≡
  ("i)/" ?ἴ) ; U+1F34 SMALL IOTA WITH PSILI AND OXIA ≡
  ("i(/" ?ἵ) ; U+1F35 SMALL IOTA WITH DASIA AND OXIA ≡
  ("i)=" ?ἶ) ; U+1F36 SMALL IOTA WITH PSILI AND PERISPOMENI ≡
  ("i(=" ?ἷ) ; U+1F37 SMALL IOTA WITH DASIA AND PERISPOMENI ≡
  ("I)" ?Ἰ) ; U+1F38 CAPITAL IOTA WITH PSILI ≡
  ("I(" ?Ἱ) ; U+1F39 CAPITAL IOTA WITH DASIA ≡
  ("I)\\" ?Ἲ) ; U+1F3A CAPITAL IOTA WITH PSILI AND VARIA ≡
  ("I(\\" ?Ἳ) ; U+1F3B CAPITAL IOTA WITH DASIA AND VARIA ≡
  ("I)/" ?Ἴ) ; U+1F3C CAPITAL IOTA WITH PSILI AND OXIA ≡
  ("I(/" ?Ἵ) ; U+1F3D CAPITAL IOTA WITH DASIA AND OXIA ≡
  ("I)=" ?Ἶ) ; U+1F3E CAPITAL IOTA WITH PSILI AND PERISPOMENI ≡
  ("I(=" ?Ἷ) ; U+1F3F CAPITAL IOTA WITH DASIA AND PERISPOMENI ≡
  ("o)" ?ὀ) ; U+1F40 SMALL OMICRON WITH PSILI ≡
  ("o(" ?ὁ) ; U+1F41 SMALL OMICRON WITH DASIA ≡
  ("o)\\" ?ὂ) ; U+1F42 SMALL OMICRON WITH PSILI AND VARIA ≡
  ("o(\\" ?ὃ) ; U+1F43 SMALL OMICRON WITH DASIA AND VARIA ≡
  ("o)/" ?ὄ) ; U+1F44 SMALL OMICRON WITH PSILI AND OXIA ≡
  ("o(/" ?ὅ) ; U+1F45 SMALL OMICRON WITH DASIA AND OXIA ≡
  ("O)" ?Ὀ) ; U+1F48 CAPITAL OMICRON WITH PSILI ≡
  ("O(" ?Ὁ) ; U+1F49 CAPITAL OMICRON WITH DASIA ≡
  ("O)\\" ?Ὂ) ; U+1F4A CAPITAL OMICRON WITH PSILI AND VARIA ≡
  ("O(\\" ?Ὃ) ; U+1F4B CAPITAL OMICRON WITH DASIA AND VARIA ≡
  ("O)/" ?Ὄ) ; U+1F4C CAPITAL OMICRON WITH PSILI AND OXIA ≡
  ("O(/" ?Ὅ) ; U+1F4D CAPITAL OMICRON WITH DASIA AND OXIA ≡
  ("u)" ?ὐ) ; U+1F50 SMALL UPSILON WITH PSILI ≡
  ("u(" ?ὑ) ; U+1F51 SMALL UPSILON WITH DASIA ≡
  ("u)\\" ?ὒ) ; U+1F52 SMALL UPSILON WITH PSILI AND VARIA ≡
  ("u(\\" ?ὓ) ; U+1F53 SMALL UPSILON WITH DASIA AND VARIA ≡
  ("u)/" ?ὔ) ; U+1F54 SMALL UPSILON WITH PSILI AND OXIA ≡
  ("u(/" ?ὕ) ; U+1F55 SMALL UPSILON WITH DASIA AND OXIA ≡
  ("u)=" ?ὖ) ; U+1F56 SMALL UPSILON WITH PSILI AND PERISPOMENI ≡
  ("u(=" ?ὗ) ; U+1F57 SMALL UPSILON WITH DASIA AND PERISPOMENI ≡
  ("U(" ?Ὑ) ; U+1F59 CAPITAL UPSILON WITH DASIA ≡
  ("U(\\" ?Ὓ) ; U+1F5B CAPITAL UPSILON WITH DASIA AND VARIA ≡
  ("U(/" ?Ὕ) ; U+1F5D CAPITAL UPSILON WITH DASIA AND OXIA ≡
  ("U(=" ?Ὗ) ; U+1F5F CAPITAL UPSILON WITH DASIA AND PERISPOMENI ≡
  ("w)" ?ὠ) ; U+1F60 SMALL OMEGA WITH PSILI ≡
  ("w(" ?ὡ) ; U+1F61 SMALL OMEGA WITH DASIA ≡
  ("w)\\" ?ὢ) ; U+1F62 SMALL OMEGA WITH PSILI AND VARIA ≡
  ("w(\\" ?ὣ) ; U+1F63 SMALL OMEGA WITH DASIA AND VARIA ≡
  ("w)/" ?ὤ) ; U+1F64 SMALL OMEGA WITH PSILI AND OXIA ≡
  ("w(/" ?ὥ) ; U+1F65 SMALL OMEGA WITH DASIA AND OXIA ≡
  ("w)=" ?ὦ) ; U+1F66 SMALL OMEGA WITH PSILI AND PERISPOMENI ≡
  ("w(=" ?ὧ) ; U+1F67 SMALL OMEGA WITH DASIA AND PERISPOMENI ≡
  ("W)" ?Ὠ) ; U+1F68 CAPITAL OMEGA WITH PSILI ≡
  ("W(" ?Ὡ) ; U+1F69 CAPITAL OMEGA WITH DASIA ≡
  ("W)\\" ?Ὢ) ; U+1F6A CAPITAL OMEGA WITH PSILI AND VARIA ≡
  ("W(\\" ?Ὣ) ; U+1F6B CAPITAL OMEGA WITH DASIA AND VARIA ≡
  ("W)/" ?Ὤ) ; U+1F6C CAPITAL OMEGA WITH PSILI AND OXIA ≡
  ("W(/" ?Ὥ) ; U+1F6D CAPITAL OMEGA WITH DASIA AND OXIA ≡
  ("W)=" ?Ὦ) ; U+1F6E CAPITAL OMEGA WITH PSILI AND PERISPOMENI ≡
  ("W(=" ?Ὧ) ; U+1F6F CAPITAL OMEGA WITH DASIA AND PERISPOMENI ≡
  ("a\\" ?ὰ) ; U+1F70 SMALL ALPHA WITH VARIA ≡
  ;;("a/" ?ά) ; U+1F71 SMALL ALPHA WITH OXIA ≡
  ("e\\" ?ὲ) ; U+1F72 SMALL EPSILON WITH VARIA ≡
  ;;("e/" ?έ) ; U+1F73 SMALL EPSILON WITH OXIA ≡
  ("h\\" ?ὴ) ; U+1F74 SMALL ETA WITH VARIA ≡
  ;;("h/" ?ή) ; U+1F75 SMALL ETA WITH OXIA ≡
  ("i\\" ?ὶ) ; U+1F76 SMALL IOTA WITH VARIA ≡
  ;;("i/" ?ί) ; U+1F77 SMALL IOTA WITH OXIA ≡
  ("o\\" ?ὸ) ; U+1F78 SMALL OMICRON WITH VARIA ≡
  ;;("o/" ?ό) ; U+1F79 SMALL OMICRON WITH OXIA ≡
  ("u\\" ?ὺ) ; U+1F7A SMALL UPSILON WITH VARIA ≡
  ;;("u/" ?ύ) ; U+1F7B SMALL UPSILON WITH OXIA ≡
  ("w\\" ?ὼ) ; U+1F7C SMALL OMEGA WITH VARIA ≡
  ;;("w/" ?ώ) ; U+1F7D SMALL OMEGA WITH OXIA ≡
  ("a)|" ?ᾀ) ; U+1F80 SMALL ALPHA WITH PSILI AND YPOGEGRAMMENI ≡
  ("a(|" ?ᾁ) ; U+1F81 SMALL ALPHA WITH DASIA AND YPOGEGRAMMENI ≡
  ("a)\\|" ?ᾂ) ; U+1F82 SMALL ALPHA WITH PSILI AND VARIA AND YPOGEGRAMMENI ≡
  ("a(\\|" ?ᾃ) ; U+1F83 SMALL ALPHA WITH DASIA AND VARIA AND YPOGEGRAMMENI ≡
  ("a)/|" ?ᾄ) ; U+1F84 SMALL ALPHA WITH PSILI AND OXIA AND YPOGEGRAMMENI ≡
  ("a(/|" ?ᾅ) ; U+1F85 SMALL ALPHA WITH DASIA AND OXIA AND YPOGEGRAMMENI ≡
  ("a)=|" ?ᾆ) ; U+1F86 SMALL ALPHA WITH PSILI AND PERISPOMENI AND YPOGEGRAMMENI ≡
  ("a(=|" ?ᾇ) ; U+1F87 SMALL ALPHA WITH DASIA AND PERISPOMENI AND YPOGEGRAMMENI ≡
  ("A)|" ?ᾈ) ; U+1F88 CAPITAL ALPHA WITH PSILI AND PROSGEGRAMMENI ≡
  ("A(|" ?ᾉ) ; U+1F89 CAPITAL ALPHA WITH DASIA AND PROSGEGRAMMENI ≡
  ("A)\\|" ?ᾊ) ; U+1F8A CAPITAL ALPHA WITH PSILI AND VARIA AND PROSGEGRAMMENI ≡
  ("A(\\|" ?ᾋ) ; U+1F8B CAPITAL ALPHA WITH DASIA AND VARIA AND PROSGEGRAMMENI ≡
  ("A)/|" ?ᾌ) ; U+1F8C CAPITAL ALPHA WITH PSILI AND OXIA AND PROSGEGRAMMENI ≡
  ("A(/|" ?ᾍ) ; U+1F8D CAPITAL ALPHA WITH DASIA AND OXIA AND PROSGEGRAMMENI ≡
  ("A)=|" ?ᾎ) ; U+1F8E CAPITAL ALPHA WITH PSILI AND PERISPOMENI AND PROSGEGRAMMENI ≡
  ("A(=|" ?ᾏ) ; U+1F8F CAPITAL ALPHA WITH DASIA AND PERISPOMENI AND PROSGEGRAMMENI ≡
  ("h)|" ?ᾐ) ; U+1F90 SMALL ETA WITH PSILI AND YPOGEGRAMMENI ≡
  ("h(|" ?ᾑ) ; U+1F91 SMALL ETA WITH DASIA AND YPOGEGRAMMENI ≡
  ("h)\\|" ?ᾒ) ; U+1F92 SMALL ETA WITH PSILI AND VARIA AND YPOGEGRAMMENI ≡
  ("h(\\|" ?ᾒ) ; U+1F93 SMALL ETA WITH DASIA AND VARIA AND YPOGEGRAMMENI ≡
  ("h)/|" ?ᾔ) ; U+1F94 SMALL ETA WITH PSILI AND OXIA AND YPOGEGRAMMENI ≡
  ("h(/|" ?ᾕ) ; U+1F95 SMALL ETA WITH DASIA AND OXIA AND YPOGEGRAMMENI ≡
  ("h)=|" ?ᾖ) ; U+1F96 SMALL ETA WITH PSILI AND PERISPOMENI AND YPOGEGRAMMENI ≡
  ("h(=|" ?ᾗ) ; U+1F97 SMALL ETA WITH DASIA AND PERISPOMENI AND YPOGEGRAMMENI ≡
  ("H)|" ?ᾘ) ; U+1F98 CAPITAL ETA WITH PSILI AND PROSGEGRAMMENI ≡
  ("H(|" ?ᾙ) ; U+1F99 CAPITAL ETA WITH DASIA AND PROSGEGRAMMENI ≡
  ("H)\\|" ?ᾚ) ; U+1F9A CAPITAL ETA WITH PSILI AND VARIA AND PROSGEGRAMMENI ≡
  ("H(\\|" ?ᾛ) ; U+1F9B CAPITAL ETA WITH DASIA AND VARIA AND PROSGEGRAMMENI ≡
  ("H)/|" ?ᾜ) ; U+1F9C CAPITAL ETA WITH PSILI AND OXIA AND PROSGEGRAMMENI ≡
  ("H(/|" ?ᾝ) ; U+1F9D CAPITAL ETA WITH DASIA AND OXIA AND PROSGEGRAMMENI ≡
  ("H(/|" ?ᾝ) ; U+1F9D CAPITAL ETA WITH DASIA AND OXIA AND PROSGEGRAMMENI ≡
  ("H)=|" ?ᾞ) ; U+1F9E CAPITAL ETA WITH PSILI AND PERISPOMENI AND PROSGEGRAMMENI ≡
  ("H(=|" ?ᾟ) ; U+1F9F CAPITAL ETA WITH DASIA AND PERISPOMENI AND PROSGEGRAMMENI ≡
  ("w)|" ?ᾠ) ; U+1FA0 SMALL OMEGA WITH PSILI AND YPOGEGRAMMENI ≡
  ("w(|" ?ᾡ) ; U+1FA1 SMALL OMEGA WITH DASIA AND YPOGEGRAMMENI ≡
  ("w)\\|" ?ᾢ) ; U+1FA2 SMALL OMEGA WITH PSILI AND VARIA AND YPOGEGRAMMENI ≡
  ("w(\\|" ?ᾣ) ; U+1FA3 SMALL OMEGA WITH DASIA AND VARIA AND YPOGEGRAMMENI ≡
  ("w)/|" ?ᾤ) ; U+1FA4 SMALL OMEGA WITH PSILI AND OXIA AND YPOGEGRAMMENI ≡
  ("w(/|" ?ᾥ) ; U+1FA5 SMALL OMEGA WITH DASIA AND OXIA AND YPOGEGRAMMENI ≡
  ("w)=|" ?ᾦ) ; U+1FA6 SMALL OMEGA WITH PSILI AND PERISPOMENI AND YPOGEGRAMMENI ≡
  ("w(=|" ?ᾧ) ; U+1FA7 SMALL OMEGA WITH DASIA AND PERISPOMENI AND YPOGEGRAMMENI ≡
  ("W)|" ?ᾨ) ; U+1FA8 CAPITAL OMEGA WITH PSILI AND PROSGEGRAMMENI ≡
  ("W(|" ?ᾩ) ; U+1FA9 CAPITAL OMEGA WITH DASIA AND PROSGEGRAMMENI ≡
  ("W)\\|" ?ᾪ) ; U+1FAA CAPITAL OMEGA WITH PSILI AND VARIA AND PROSGEGRAMMENI ≡
  ("W(\\|" ?ᾫ) ; U+1FAB CAPITAL OMEGA WITH DASIA AND VARIA AND PROSGEGRAMMENI ≡
  ("W)/|" ?ᾬ) ; U+1FAC CAPITAL OMEGA WITH PSILI AND OXIA AND PROSGEGRAMMENI ≡
  ("W(/|" ?ᾭ) ; U+1FAD CAPITAL OMEGA WITH DASIA AND OXIA AND PROSGEGRAMMENI ≡
  ("W)=|" ?ᾮ) ; U+1FAE CAPITAL OMEGA WITH PSILI AND PERISPOMENI AND PROSGEGRAMMENI ≡
  ("W(=|" ?ᾯ) ; U+1FAF CAPITAL OMEGA WITH DASIA AND PERISPOMENI AND PROSGEGRAMMENI ≡
  ("a'" ?ᾰ) ; U+1FB0 SMALL ALPHA WITH VRACHY ≡
  ("a&" ?ᾱ) ; U+1FB1 SMALL ALPHA WITH MACRON ≡
  ("a\\|" ?ᾲ) ; U+1FB2 SMALL ALPHA WITH VARIA AND YPOGEGRAMMENI ≡
  ("a|" ?ᾳ) ; U+1FB3 SMALL ALPHA WITH YPOGEGRAMMENI ≡
  ("a/|" ?ᾴ) ; U+1FB4 SMALL ALPHA WITH OXIA AND YPOGEGRAMMENI ≡
  ("a=" ?ᾶ) ; U+1FB6 SMALL ALPHA WITH PERISPOMENI ≡
  ("a=| " ?ᾷ) ; U+1FB7 SMALL ALPHA WITH PERISPOMENI AND YPOGEGRAMMENI ≡
  ("A'" ?Ᾰ) ; U+1FB8 CAPITAL ALPHA WITH VRACHY ≡
  ("A&" ?Ᾱ) ; U+1FB9 CAPITAL ALPHA WITH MACRON ≡
  ("A\\" ?Ὰ) ; U+1FBA CAPITAL ALPHA WITH VARIA ≡
  ;;("A/" ?Ά) ; U+1FBB CAPITAL ALPHA WITH OXIA ≡
  ("A|" ?ᾼ) ; U+1FBC CAPITAL ALPHA WITH PROSGEGRAMMENI ≡
  ("h\\|" ?ῂ) ; U+1FC2 SMALL ETA WITH VARIA AND YPOGEGRAMMENI ≡
  ("h|" ?ῃ) ; U+1FC3 SMALL ETA WITH YPOGEGRAMMENI ≡
  ("h/|" ?ῄ) ; U+1FC4 SMALL ETA WITH OXIA AND YPOGEGRAMMENI ≡
  ("h=" ?ῆ) ; U+1FC6 SMALL ETA WITH PERISPOMENI ≡
  ("h=|" ?ῇ) ; U+1FC7 SMALL ETA WITH PERISPOMENI AND YPOGEGRAMMENI ≡
  ("E\\" ?Ὲ) ; U+1FC8 CAPITAL EPSILON WITH VARIA ≡
  ;;("E/" ?Έ) ; U+1FC9 CAPITAL EPSILON WITH OXIA ≡
  ("H\\" ?Ὴ) ; U+1FCA CAPITAL ETA WITH VARIA ≡
  ;;("H/" ?Ή) ; U+1FCB CAPITAL ETA WITH OXIA ≡
  ("H|" ?ῌ) ; U+1FCC CAPITAL ETA WITH PROSGEGRAMMENI ≡
  ("i'" ?ῐ) ; U+1FD0 SMALL IOTA WITH VRACHY ≡
  ("i&" ?ῑ) ; U+1FD1 SMALL IOTA WITH MACRON ≡
  ("i+\\" ?ῒ) ; U+1FD2 SMALL IOTA WITH DIALYTIKA AND VARIA ≡
  ("i+/" ?ΐ) ; U+1FD3 SMALL IOTA WITH DIALYTIKA AND OXIA ≡
  ("i=" ?ῖ) ; U+1FD6 SMALL IOTA WITH PERISPOMENI ≡
  ("i+=" ?ῗ) ; U+1FD7 SMALL IOTA WITH DIALYTIKA AND PERISPOMENI ≡
  ("I'" ?Ῐ) ; U+1FD8 CAPITAL IOTA WITH VRACHY ≡
  ("I&" ?Ῑ) ; U+1FD9 CAPITAL IOTA WITH MACRON ≡
  ("I\\" ?Ὶ) ; U+1FDA CAPITAL IOTA WITH VARIA ≡
  ("I/" ?Ί) ; U+1FDB CAPITAL IOTA WITH OXIA ≡
  ("u'" ?ῠ) ; U+1FE0 SMALL UPSILON WITH VRACHY ≡
  ("u&" ?ῡ) ; U+1FE1 SMALL UPSILON WITH MACRON ≡
  ("u+\\" ?ῢ) ; U+1FE2 SMALL UPSILON WITH DIALYTIKA AND VARIA ≡
  ;;("u+/" ?ΰ) ; U+1FE3 SMALL UPSILON WITH DIALYTIKA AND OXIA ≡
  ("r)" ?ῤ) ; U+1FE4 SMALL RHO WITH PSILI ≡
  ("r(" ?ῥ) ; U+1FE5 SMALL RHO WITH DASIA ≡
  ("u=" ?ῦ) ; U+1FE6 SMALL UPSILON WITH PERISPOMENI ≡
  ("u+=" ?ῧ) ; U+1FE7 SMALL UPSILON WITH DIALYTIKA AND PERISPOMENI ≡
  ("U'" ?Ῠ) ; U+1FE8 CAPITAL UPSILON WITH VRACHY ≡
  ("U&" ?Ῡ) ; U+1FE9 CAPITAL UPSILON WITH MACRON ≡
  ("U\\" ?Ὺ) ; U+1FEA CAPITAL UPSILON WITH VARIA ≡
  ;;("U/" ?Ύ) ; U+1FEB CAPITAL UPSILON WITH OXIA ≡
  ("R(" ?Ῥ) ; U+1FEC CAPITAL RHO WITH DASIA ≡
  ("w\\|" ?ῲ) ; U+1FF2 SMALL OMEGA WITH VARIA AND YPOGEGRAMMENI ≡
  ("w|" ?ῳ) ; U+1FF3 SMALL OMEGA WITH YPOGEGRAMMENI ≡
  ("w/|" ?ῴ) ; U+1FF4 SMALL OMEGA WITH OXIA AND YPOGEGRAMMENI ≡
  ("w=" ?ῶ) ; U+1FF6 SMALL OMEGA WITH PERISPOMENI ≡
  ("w=|" ?ῷ) ; U+1FF7 SMALL OMEGA WITH PERISPOMENI AND YPOGEGRAMMENI ≡
  ("O\\" ?Ὸ) ; U+1FF8 CAPITAL OMICRON WITH VARIA ≡
  ;;("O/" ?Ό) ; U+1FF9 CAPITAL OMICRON WITH OXIA ≡
  ("W\\" ?Ὼ) ; U+1FFA CAPITAL OMEGA WITH VARIA ≡
  ;;("W/" ?Ώ) ; U+1FFB CAPITAL OMEGA WITH OXIA ≡
  ("W|" ?ῼ) ; U+1FFC CAPITAL OMEGA WITH PROSGEGRAMMENI ≡
  
  ;; Macron and Breve
  ;; TODO: I AND Y CON <diaeresis> DOPO MACRON/VRACHY
  ("a&)" [ᾱ̓])	; SMALL ALPHA WITH MACRON AND PSILI
  ("a&)/" [ᾱ̓́]) 	; SMALL ALPHA WITH MACRON AND PSILI AND OXIA
  ("a&)\\" [ᾱ̓̀]) ; SMALL ALPHA WITH MACRON AND PSILI AND VARIA
  ("a&(" [ᾱ̔]) 	; SMALL ALPHA WITH MACRON AND DASIA
  ("a&(/" [ᾱ̔́]) 	; SMALL ALPHA WITH MACRON AND DASIA AND OXIA
  ("a&(\\" [ᾱ̔̀])	; SMALL ALPHA WITH MACRON AND DASIA AND VARIA
  ("a')" [ᾰ̓])	; SMALL ALPHA WITH VRACHY AND PSILI
  ("a')/" [ᾰ̓́]) 	; SMALL ALPHA WITH VRACHY AND PSILI AND OXIA
  ("a')\\" [ᾰ̓̀]) ; SMALL ALPHA WITH VRACHY AND PSILI AND VARIA
  ("a'(" [ᾰ̔]) 	; SMALL ALPHA WITH VRACHY AND DASIA
  ("a'(/" [ᾰ̔́]) 	; SMALL ALPHA WITH VRACHY AND DASIA AND OXIA
  ("a'(\\" [ᾰ̔̀]) ; SMALL ALPHA WITH VRACHY AND DASIA AND VARIA
  ("i&)" [ῑ̓])	; SMALL IOTA WITH MACRON AND PSILI
  ("i&)/" [ῑ̓́]) 	; SMALL IOTA WITH MACRON AND PSILI AND OXIA
  ("i&)\\" [ῑ̓̀]) ; SMALL IOTA WITH MACRON AND PSILI AND VARIA
  ("i&(" [ῑ̔]) 	; SMALL IOTA WITH MACRON AND DASIA
  ("i&(/" [ῑ̔́]) 	; SMALL IOTA WITH MACRON AND DASIA AND OXIA
  ("i&(\\" [ῑ̔̀])	; SMALL IOTA WITH MACRON AND DASIA AND VARIA
  ("i')" [ῐ̓])	; SMALL IOTA WITH VRACHY AND PSILI
  ("i')/" [ῐ̓́]) 	; SMALL IOTA WITH VRACHY AND PSILI AND OXIA
  ("i')\\" [ῐ̓̀]) ; SMALL IOTA WITH VRACHY AND PSILI AND VARIA
  ("i'(" [ῐ̔]) 	; SMALL IOTA WITH VRACHY AND DASIA
  ("i'(/" [ῐ̔́]) 	; SMALL IOTA WITH VRACHY AND DASIA AND OXIA
  ("i'(\\" [ῐ̔̀]) ; SMALL IOTA WITH VRACHY AND DASIA AND VARIA
  ("u&)" [ῡ̓])	; SMALL UPSILON WITH MACRON AND PSILI
  ("u&)/" [ῡ̓́]) 	; SMALL UPSILON WITH MACRON AND PSILI AND OXIA
  ("u&)\\" [ῡ̓̀]) ; SMALL UPSILON WITH MACRON AND PSILI AND VARIA
  ("u&(" [ῡ̔]) 	; SMALL UPSILON WITH MACRON AND DASIA
  ("u&(/" [ῡ̔́]) 	; SMALL UPSILON WITH MACRON AND DASIA AND OXIA
  ("u&(\\" [ῡ̔̀])	; SMALL UPSILON WITH MACRON AND DASIA AND VARIA
  ("u')" [ῠ̓])	; SMALL UPSILON WITH VRACHY AND PSILI
  ("u')/" [ῠ̓́]) 	; SMALL UPSILON WITH VRACHY AND PSILI AND OXIA
  ("u')\\" [ῠ̓̀]) ; SMALL UPSILON WITH VRACHY AND PSILI AND VARIA
  ("u'(" [ῠ̔]) 	; SMALL UPSILON WITH VRACHY AND DASIA
  ("u'(/" [ῠ̔́]) 	; SMALL UPSILON WITH VRACHY AND DASIA AND OXIA
  ("u'(\\" [ῠ̔̀]) ; SMALL UPSILON WITH VRACHY AND DASIA AND VARIA

  ;; QWERTY keyboard mappings provided behind a backslash escape
  ("\\1" ?1)
  ("\\!" ?!)
  ("\\2" ?2)
  ("\\@" ?@)
  ("\\3" ?3)
  ("\\#" ?#)
  ("\\4" ?4)
  ("\\$" ?$)
  ("\\5" ?5)
  ("\\%" ?%)
  ("\\6" ?6)
  ("\\^" ?^)
  ("\\7" ?7)
  ("\\&" ?&)
  ("\\8" ?8)
  ("\\*" ?*)
  ("\\9" ?9)
  ("\\(" ?\()
  ("\\0" ?0)
  ("\\)" ?\))
  ("\\-" ?-)
  ("\\_" ?_)
  ("\\=" ?=)
  ("\\+" ?+)
  ("\\`" ?`)
  ("\\~" ?~)
  ("\\q" ?q)
  ("\\Q" ?Q)
  ("\\w" ?w)
  ("\\W" ?W)
  ("\\e" ?e)
  ("\\E" ?E)
  ("\\r" ?r)
  ("\\R" ?R)
  ("\\t" ?t)
  ("\\T" ?T)
  ("\\y" ?y)
  ("\\Y" ?Y)
  ("\\u" ?u)
  ("\\U" ?U)
  ("\\i" ?i)
  ("\\I" ?I)
  ("\\o" ?o)
  ("\\O" ?O)
  ("\\p" ?p)
  ("\\P" ?P)
  ("\\{" ?{)
  ("\\]" ?\])
  ("\\}" ?})
  ("\\a" ?a)
  ("\\A" ?A)
  ("\\s" ?s)
  ("\\S" ?S)
  ("\\d" ?d)
  ("\\D" ?D)
  ("\\f" ?f)
  ("\\F" ?F)
  ("\\g" ?g)
  ("\\G" ?G)
  ("\\h" ?h)
  ("\\H" ?H)
  ("\\j" ?j)
  ("\\J" ?J)
  ("\\k" ?k)
  ("\\K" ?K)
  ("\\l" ?l)
  ("\\L" ?L)
  ("\\;" ?\;)
  ("\\:" ?:) ; U+003A COLON
  ("\\'" ?')
  ("\\\"" ?\")
  ("\\\\" ?\\)
  ("\\|" ?|)
  ("\\z" ?z)
  ("\\Z" ?Z)
  ("\\x" ?x)
  ("\\X" ?X)
  ("\\c" ?c)
  ("\\C" ?C)
  ("\\v" ?v)
  ("\\V" ?V)
  ("\\b" ?b)
  ("\\B" ?B)
  ("\\n" ?n)
  ("\\N" ?N)
  ("\\m" ?m)
  ("\\M" ?M)
  ("\\," ?,)
  ("\\<" ?<)
  ("\\." ?.)
  ("\\>" ?>)
  ("\\/" ?/)
  ("\\?" ??)

  ;; Some useful punctuation on AltGr keys of US keyboards provided
  ;; behind a "|" escape
  ("|\\" ?«) ; U+00AB LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
  ("||" ?»)) ; U+00BB RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK

(provide 'greek-beta-code)
;;; greek-beta-code.el ends here

;; Local Variables:
;; coding: utf-8
;; mode: emacs-lisp
;; End:
