(spacemacs|define-transient-state realgud
  :title "RealGUD transient state"
  :doc
  "
  :flow:          :breaks:        :misc:
  ----------------------------------------------
  [_n_] Next      [_bb_] Break    [_F_] Bactrace buffer
  [_s_] Step in   [_bd_] Delete   [_u_] Up
  [_f_] Step out  [_bs_] Disable  [_d_] Down
  [_c_] Continue  [_be_] Enable   [_e_] Eval
  [_J_] Jump      [_bc_] Clear    [_S_] Avy
   ^ ^             ^ ^            [_q_] Quit [_Q_] Quit debugger
  "
  :on-enter (debug--realgud-init)
  :on-exit (realgud-short-key-mode-off)
  :bindings
  ("n" realgud:cmd-next)
  ("s" realgud:cmd-step)
  ("f" realgud:cmd-finish)
  ("c" realgud:cmd-continue)
  ("J" realgud:cmd-jump)
  ("bb" realgud:cmd-break)
  ("bd" realgud:cmd-delete)
  ("bs" realgud:cmd-disable)
  ("be" realgud:cmd-enable)
  ("bc" realgud:cmd-clear)
  ("F" realgud:window-bt)
  ("u" realgud:cmd-older-frame)
  ("d" realgud:cmd-newer-frame)
  ("e" debug--realgud-eval-dwim)
  ("S" avy-goto-char-timer)
  ("q" nil :exit t)
  ("Q" realgud:cmd-quit :exit t))
