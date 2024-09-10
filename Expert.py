import tkinter as tk
from tkinter import filedialog, messagebox
from openpyxl import load_workbook
from docx import Document
from docx.shared import Pt
import os

def load_excel_file():
    file_path = filedialog.askopenfilename(filetypes=[("Excel files", "*.xlsx")])
    if file_path:
        entry_excel.delete(0, tk.END)
        entry_excel.insert(0, file_path)

def load_docx_file():
    file_path = filedialog.askopenfilename(filetypes=[("Word files", "*.docx")])
    if file_path:
        entry_docx.delete(0, tk.END)
        entry_docx.insert(0, file_path)

def create_documents():
    try:
        excel_path = entry_excel.get()
        column_address = entry_column.get().strip().upper()  # Получаем адрес столбца
        row_range = entry_range.get()
        docx_path = entry_docx.get()

        # Преобразуем диапазон строк в индексы
        start_row, end_row = map(int, row_range.split('-'))

        # Загружаем данные из Excel
        wb = load_workbook(excel_path)
        sheet = wb.active

        # Извлекаем нужные данные по адресу столбца
        data = [sheet[f"{column_address}{row}"].value for row in range(start_row + 1, end_row + 2)]  # +1 для заголовка

        # Проверяем, существует ли файл .docx
        if not os.path.exists(docx_path):
            raise FileNotFoundError("Файл .docx не найден.")

        # Получаем директорию для сохранения новых файлов
        save_directory = os.path.dirname(docx_path)

        for i, value in enumerate(data, start=1):
            # Создаем новый документ на основе оригинала
            new_doc = Document(docx_path)

            # Заменяем все вхождения "7-13" на значение из Excel
            for paragraph in new_doc.paragraphs:
                if "7-13" in paragraph.text:
                    paragraph.text = paragraph.text.replace("7-13", str(value))

                # Устанавливаем шрифт и размер для каждого параграфа
                for run in paragraph.runs:
                    run.font.name = 'Times New Roman'
                    run.font.size = Pt(14)

            # Сохраняем новый документ с именем 1.docx, 2.docx и т.д.
            new_doc.save(os.path.join(save_directory, f"{i}.docx"))

        messagebox.showinfo("Успех", f"{len(data)} документов успешно созданы!")

    except Exception as e:
        messagebox.showerror("Ошибка", str(e))

# Создаем главное окно
root = tk.Tk()
root.title("Excel to Word Document Creator")

# Создаем элементы интерфейса
label_excel = tk.Label(root, text="Выберите файл .xlsx:")
label_excel.pack()

entry_excel = tk.Entry(root, width=50)
entry_excel.pack()

button_load_excel = tk.Button(root, text="Загрузить файл Excel", command=load_excel_file)
button_load_excel.pack()

label_column = tk.Label(root, text="Введите адрес столбца (например, A):")
label_column.pack()

entry_column = tk.Entry(root)
entry_column.pack()

label_range = tk.Label(root, text="Введите диапазон строк (например, 0-10):")
label_range.pack()

entry_range = tk.Entry(root)
entry_range.pack()

label_docx = tk.Label(root, text="Выберите файл .docx:")
label_docx.pack()

entry_docx = tk.Entry(root, width=50)
entry_docx.pack()

button_load_docx = tk.Button(root, text="Загрузить файл Word", command=load_docx_file)
button_load_docx.pack()

button_run = tk.Button(root, text="Запустить", command=create_documents)
button_run.pack()

# Запускаем главный цикл приложения
root.mainloop()
