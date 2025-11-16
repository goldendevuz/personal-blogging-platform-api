#!/bin/bash

PROJECT_DIR="/workspaces/personal-blogging-platform-api"
DJANGO_SETTINGS="personal_blog_api.settings"
GUNICORN_APP="personal_blog_api.wsgi:application"

# 1. Start Django API in tmux session "api"
echo "Starting Gunicorn in tmux session 'api'..."
tmux kill-session -t api 2>/dev/null
tmux new -d -s api "cd $PROJECT_DIR && gunicorn $GUNICORN_APP --bind 0.0.0.0:8000"

sleep 2

# 2. Start ngrok in tmux session "ngrok"
echo "Starting ngrok in tmux session 'ngrok'..."
tmux kill-session -t ngrok 2>/dev/null
tmux new -d -s ngrok "ngrok http 8000"

sleep 3

# 3. Fetch public URL from ngrok API
NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*' | head -1)

echo "--------------------------------------"
echo "Your API is now online!"
echo "Public URL: $NGROK_URL"
echo "--------------------------------------"

echo "To view logs:"
echo "  tmux attach -t api"
echo "  tmux attach -t ngrok"
