# Computer-Organization-And-Assembly-Language
Explores the link between hardware and software. Focuses on CPU architecture, registers, and memory management. Using x86 Assembly and DOS interrupts, I developed low-level logic for direct hardware interaction, disk I/O, and system-level optimization
"Bridging the gap between software logic and hardware execution. Specialized in x86 Assembly programming, memory management, and understanding the internal architecture of modern microprocessors."
To make your GitHub repository stand out and be accessible to everyone—from beginners to experts—you need a **README** that is clean, visual, and easy to follow.

Here is a complete, professional, and visually structured **README.md** for your Task Manager project.

---

# 📝 x86 Assembly Task Manager

> **A Low-Level Persistent Task Management System built with NASM.**

This project is a CLI-based Task Manager that communicates directly with the **MS-DOS Kernel**. It demonstrates the power of **Assembly Language** by performing file I/O operations without the help of high-level libraries.

---

## 🚀 Features

* **Direct File I/O:** Creates and manages `data.txt` using DOS interrupts.
* **Persistent Storage:** Tasks are saved to the disk and remain available after program exit.
* **Smart Appending:** Uses `LSEEK` logic to add new records to the end of the file.
* **Priority Levels:** Assign priority (1-3) to organize your workflow.
* **Zero Dependencies:** Written in pure x86 Assembly.

---

## 🛠️ Tech Stack & Requirements

* **Language:** x86 Assembly (16-bit Real Mode)
* **Assembler:** [NASM](https://www.nasm.us/)
* **Environment:** [DOSBox](https://www.dosbox.com/)
* **Interface:** MS-DOS Interrupt 21h

---

## 📥 How To Run (Beginner's Guide)

Follow these steps to get the project running on your machine:

### 1. Setup Environment

Ensure you have **DOSBox** installed and the **NASM** executable (`nasm.exe`) available in your project folder.

### 2. Compilation

Open DOSBox and mount your project directory. Run the following command to assemble the source code into a `.com` executable:

```bash
nasm -f bin task.asm -o task.com

```

### 3. Execution

Launch the program by typing:

```bash
task.com

```

### 4. Navigating the Menu

* Press **1** to add a new task (it will ask for priority and description).
* Press **2** to view all tasks stored in `data.txt`.
* Press **3** to exit the application.

---

## 🏗️ Architecture & Logic

The program follows a strictly regulated cycle to ensure data integrity and memory efficiency.

### **Interrupt Reference Table**

The following **INT 21h** functions are the backbone of this project:

| AH | Operation | Purpose |
| --- | --- | --- |
| `3Ch` | Create File | Generates `data.txt` on the first run. |
| `3Dh` | Open File | Accesses the file in Read/Write mode. |
| `42h` | LSEEK | Moves the file pointer to the end for appending. |
| `40h` | Write File | Commits your task data to the disk. |
| `3Fh` | Read File | Streams data from disk to terminal. |
| `3Eh` | Close File | Releases the file handle safely. |

---

## 🧠 Key Learnings

* **Register Manipulation:** Managed data flow using `AX`, `BX`, `CX`, and `DX`.
* **Memory Displacement:** Resolved "Short Jump out of range" errors using **Near Jumps**.
* **Buffer Management:** Handled manual string buffering for input and output.

---

### **Suggested GitHub Topics**

`assembly` `x86` `nasm` `dosbox` `low-level` `file-handling` `computer-organization`

---
