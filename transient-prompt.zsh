# =========================================================
# Transient Prompt (仿 p10k 的历史行压缩效果)
# =========================================================
# starship 官方文档里 transient prompt 只写了 PowerShell / Fish /
# Bash(配 Ble.sh)的方案，zsh 没有官方支持，这里用 zsh 自己的
# zle-line-finish hook 手动实现同样的效果：
#
#   1. 你按下回车提交命令(或 Ctrl+C 放弃这一行)
#   2. 这段代码把 PROMPT 临时换成精简版（只剩一个箭头）
#   3. 用 zle .reset-prompt 重绘一次，屏幕上刚才那一整块
#      "os/目录/时间" 的完整 prompt 就变成了一个箭头
#   4. 把 PROMPT 换回完整版，供下一次真正显示用
#   5. 命令的输出正常显示在这个精简箭头下面
#
# 效果：历史里堆的都是一行一个箭头，只有你正在输入的这一行
# 是完整的 os/目录/时间 那一套。
#
# 注意：这里必须用 add-zle-hook-widget 注册，而不是直接
# `zle -N zle-line-init`。zsh-autocomplete / history-substring-search
# 也挂在 line-init / line-finish 上，直接覆盖会把它们的 hook
# 挤到错误的时机运行（补全状态不重置、回车后还在跑异步补全）。

_transient_prompt_line_finish() {
  local saved_prompt=$PROMPT
  local saved_rprompt=$RPROMPT

  # 精简版：只保留箭头（会根据上一条命令是否成功变红/变绿）
  PROMPT="$(starship module character --status=$STARSHIP_CMD_STATUS --keymap=${KEYMAP:-viins})"
  RPROMPT=''
  zle .reset-prompt

  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt
}
autoload -Uz add-zle-hook-widget
add-zle-hook-widget line-finish _transient_prompt_line_finish
