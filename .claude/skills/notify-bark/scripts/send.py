#!/usr/bin/env python3
import argparse
import json
import urllib.request
import sys
import os
import subprocess
import platform

def send_notification(key, title, body, group=None, level=None, icon=None, url=None):
    # Use the JSON endpoint which allows device_key in body
    api_url = "https://api.day.app/push"
    
    payload = {
        "device_key": key,
        "title": title,
        "body": body
    }
    
    if group:
        payload["group"] = group
    if level:
        payload["level"] = level
    if icon:
        payload["icon"] = icon
    if url:
        payload["url"] = url
        
    headers = {
        "Content-Type": "application/json; charset=utf-8"
    }
    
    try:
        data = json.dumps(payload).encode('utf-8')
        req = urllib.request.Request(api_url, data=data, headers=headers, method='POST')
        
        with urllib.request.urlopen(req) as response:
            resp_body = response.read().decode('utf-8')
            print(f"Notification sent. Response: {resp_body}")
            return True
            
    except Exception as e:
        print(f"Error sending notification: {e}", file=sys.stderr)
        return False

def send_macos_notification(title, body):
    """
    Send a macOS desktop notification using AppleScript via osascript.
    """
    if platform.system() != 'Darwin':
        return

    try:
        # Escape quotes to avoid AppleScript syntax errors
        title_esc = title.replace('"', '\\"')
        body_esc = body.replace('"', '\\"')
        
        script = f'display notification "{body_esc}" with title "{title_esc}"'
        subprocess.run(['osascript', '-e', script], check=True)
        print("macOS notification sent.")
    except Exception as e:
        print(f"Warning: Failed to send macOS notification: {e}", file=sys.stderr)

def main():
    parser = argparse.ArgumentParser(description='Send Bark notification')
    parser.add_argument('--key', help='Bark device key (or set BARK_KEY env var)')
    parser.add_argument('--title', required=True, help='Notification title')
    parser.add_argument('--body', required=True, help='Notification body')
    parser.add_argument('--group', help='Notification group')
    parser.add_argument('--level', help='Notification level (active, timeSensitive, passive)')
    parser.add_argument('--icon', help='Notification icon URL')
    parser.add_argument('--url', help='Click URL')
    
    args = parser.parse_args()
    
    args = parser.parse_args()
    
    # Try to load from config.json
    config_key = None
    script_dir = os.path.dirname(os.path.abspath(__file__))
    config_path = os.path.join(script_dir, "config.json")
    if os.path.exists(config_path):
        try:
            with open(config_path, 'r') as f:
                config = json.load(f)
                config_key = config.get("bark_key")
        except Exception as e:
            print(f"Warning: Failed to read config.json: {e}", file=sys.stderr)

    key = args.key or os.environ.get('BARK_KEY') or config_key
    if not key:
        print("Error: Bark key is required. Provide --key, set BARK_KEY env var, or put in config.json.", file=sys.stderr)
        sys.exit(1)
        
    success = send_notification(key, args.title, args.body, args.group, args.level, args.icon, args.url)
    
    # Also send macOS notification if we are on macOS
    send_macos_notification(args.title, args.body)
    
    if not success:
        sys.exit(1)

if __name__ == "__main__":
    main()
