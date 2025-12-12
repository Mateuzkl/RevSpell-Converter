// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

#[tauri::command]
fn select_folder() -> Result<String, String> {
    use rfd::FileDialog;
    let folder = FileDialog::new().pick_folder();
    match folder {
        Some(path) => Ok(path.to_string_lossy().to_string()),
        None => Err("Nenhuma pasta selecionada".to_string()),
    }
}

#[tauri::command]
fn read_file(path: String) -> Result<String, String> {
    std::fs::read_to_string(path).map_err(|e| e.to_string())
}

#[tauri::command]
fn list_files(folder: String, extension: String) -> Result<Vec<String>, String> {
    use std::fs;
    let entries = fs::read_dir(&folder).map_err(|e| e.to_string())?;
    let mut files = Vec::new();
    for entry in entries.flatten() {
        let path = entry.path();
        if path.is_file() {
            if let Some(ext) = path.extension() {
                if ext.to_str() == Some(&extension) {
                    files.push(path.to_string_lossy().to_string());
                }
            }
        }
    }
    Ok(files)
}

#[tauri::command]
fn save_file(path: String, content: String) -> Result<(), String> {
    if let Some(parent) = std::path::Path::new(&path).parent() {
        std::fs::create_dir_all(parent).map_err(|e| e.to_string())?;
    }
    std::fs::write(path, content).map_err(|e| e.to_string())
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![
            select_folder,
            read_file,
            list_files,
            save_file
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
