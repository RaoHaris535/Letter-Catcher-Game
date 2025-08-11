# 🎮 Word Catcher – Assembly Language Game

This is a **Letter Catcher** game developed by me and my friend **Abdul Moeez** as part of the *Computer Organization and Assembly Language* course in our **BSCS degree program**.  
The game is written entirely in **x86 Assembly (16-bit real mode)** and runs in a DOS text-mode environment. You control a moving box at the bottom of the screen to **catch falling characters** and avoid missing them. The game tests your reaction time and coordination while tracking your **score** and **missed characters** in real time.

---

## 📜 Game Overview
- **Platform:** DOS (x86, 16-bit real mode)  
- **Language:** Assembly (MASM/TASM compatible syntax)  
- **Video Mode:** Text Mode (80x25, B800h video memory)  
- **Input:** Keyboard (interrupt-driven)  
- **Output:** Direct screen memory manipulation  

The game starts with a **menu** offering:
1. **Start Game**
2. **View Game Records**
3. **Exit**

---

## 🕹 Gameplay
- Move your **box** left/right using the **Arrow Keys**.
- Catch the falling **letters** before they reach the bottom.
- **Score** increases when you catch a letter.
- **Missed counter** increases when you fail to catch a letter.
- Game ends when you miss **10 letters**.

---

## ✨ Features
- **Start Menu UI** with navigation using arrow keys.
- **Random letter generation** with varying speeds.
- **Multiple falling objects** at once.
- **Real-time score & missed count display**.
- **Game over screen** with final stats.
- **Record history** stored in memory during the session.
- **Interrupt-driven keyboard & timer control** for smooth gameplay.
- **Direct video memory manipulation** for fast rendering.

---

## 🛠 Technical Details
- **Keyboard ISR** (Interrupt Service Routine) to detect arrow key presses and move the box.
- **Timer ISR** for controlling the speed of falling letters.
- **Random generation** using BIOS time interrupts (INT 1Ah).
- **Direct writes** to `0xB800` segment for instant text mode rendering.
- **Screen clearing** using `REP STOSW`.
- **Stack-based numeric printing** for score/life display.
