import os
from tkinter import Tk, Button, Label, Entry, filedialog, messagebox
from docx import Document  # Импортируем класс Document из библиотеки python-docx


class DocumentReplacer:
    def __init__(self, master):
        self.master = master
        self.master.title("Документ Замена")

        self.label = Label(master, text="Выберите файлы .doc и .docx:")
        self.label.pack()

        self.select_button = Button(master, text="Выбрать файлы", command=self.select_files)
        self.select_button.pack()

        self.label_replace = Label(master, text="Введите текст для замены:")
        self.label_replace.pack()

        self.entry_replace = Entry(master)
        self.entry_replace.pack()

        self.label_with = Label(master, text="Введите новый текст:")
        self.label_with.pack()

        self.entry_with = Entry(master)
        self.entry_with.pack()

        self.start_button = Button(master, text="Старт", command=self.start_replacement)
        self.start_button.pack()

        self.files = []

    def select_files(self):
        self.files = filedialog.askopenfilenames(title="Выберите документы", filetypes=[("Word files", "*.doc;*.docx")])
        if not self.files:
            messagebox.showwarning("Предупреждение", "Файлы не выбраны!")

    def start_replacement(self):
        text_to_replace = self.entry_replace.get()
        new_text = self.entry_with.get()

        if not self.files or not text_to_replace or not new_text:
            messagebox.showwarning("Предупреждение", "Пожалуйста, заполните все поля и выберите файлы!")
            return

        for file in self.files:
            if file.endswith('.docx'):
                self.replace_in_docx(file, text_to_replace, new_text)
            else:
                messagebox.showwarning("Предупреждение", f"Файл {file} не поддерживается. Используйте .docx.")

        messagebox.showinfo("Информация", "Замена завершена!")

    def replace_in_docx(self, file_path, old_text, new_text):
        doc = Document(file_path)  # Открываем документ
        for paragraph in doc.paragraphs:
            if old_text in paragraph.text:
                inline = paragraph.runs
                for i in range(len(inline)):
                    if old_text in inline[i].text:
                        # Заменяем текст и сохраняем стиль
                        inline[i].text = inline[i].text.replace(old_text, new_text)

        doc.save(file_path)  # Сохраняем изменения в файл


if __name__ == "__main__":
    root = Tk()
    app = DocumentReplacer(root)
    root.mainloop()
