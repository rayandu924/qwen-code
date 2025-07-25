@echo off
echo ============================================
echo     Qwen Code - Installation avec Ollama
echo ============================================
echo.

REM Vérifier si Node.js est installé
node --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Node.js n'est pas installé !
    echo 📥 Téléchargez Node.js depuis https://nodejs.org
    pause
    exit /b 1
)

REM Vérifier si Ollama est installé
ollama --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Ollama n'est pas installé !
    echo 📥 Téléchargez Ollama depuis https://ollama.ai
    pause
    exit /b 1
)

echo ✅ Node.js détecté : 
node --version

echo ✅ Ollama détecté :
ollama --version

echo.
echo 📦 Installation des dépendances...
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Erreur lors de l'installation des dépendances
    pause
    exit /b 1
)

echo.
echo 🔨 Construction du projet...
call npm run build
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Erreur lors de la construction
    pause
    exit /b 1
)

echo.
echo 🌍 Installation globale...
call npm install -g .
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Erreur lors de l'installation globale
    echo ⚠️  Essayez d'exécuter ce script en tant qu'administrateur
    pause
    exit /b 1
)

echo.
echo 🎯 Configuration des variables d'environnement...
setx OPENAI_API_KEY "ollama" >nul
setx OPENAI_BASE_URL "http://localhost:11434/v1" >nul
setx OPENAI_MODEL "qwen3:1.7b" >nul

echo.
echo 📚 Téléchargement du modèle Qwen (peut prendre quelques minutes)...
echo Téléchargement de qwen3:1.7b...
ollama pull qwen3:1.7b
if %ERRORLEVEL% NEQ 0 (
    echo ⚠️  Erreur lors du téléchargement du modèle
    echo 💡 Vous pouvez le télécharger manuellement avec : ollama pull qwen3:1.7b
)

echo.
echo ============================================
echo ✅ Installation terminée avec succès !
echo ============================================
echo.
echo 🚀 Pour utiliser Qwen Code :
echo.
echo 1. Ouvrez un NOUVEAU terminal (pour les variables d'environnement)
echo 2. Démarrez Ollama : ollama serve
echo 3. Naviguez vers votre projet : cd "votre-projet"
echo 4. Lancez Qwen Code : qwen
echo.
echo 📋 Modèles disponibles :
echo   - qwen3:1.7b (léger, déjà téléchargé)
echo   - qwen2.5-coder:7b (plus performant, à télécharger)
echo   - deepseek-coder:6.7b (spécialisé code)
echo.
echo Pour télécharger un modèle plus performant :
echo   ollama pull qwen2.5-coder:7b
echo.
pause