import subprocess
import json
import sys

def run_commands(deploymentInformation):
    try:
        print("Running publish command...")
        publish_command = [
            "dotnet", "publish", fr"{deploymentInformation['projectLocation']}", "-c", "Release", "-r", "linux-x64", 
            "--self-contained", "true", "-o", f"{deploymentInformation['localPublishLocation']}/publish"
        ]
        subprocess.run(publish_command, check=True)
        print("Publish completed successfully.")

        print("Running command to transfer to remote server...")
        scp_command = [
            "scp", "-r", "-i",
            fr"{deploymentInformation['sshKeyLocation']}",
            fr"{deploymentInformation['localPublishLocation']}",
            f"{deploymentInformation['remotePublishLocation']}"
        ]
        subprocess.run(scp_command, check=True)
        print("Command to transfer to remote server completed successfully.")

    except subprocess.CalledProcessError as e:
        print(f"An error occurred while running the command: {e}")

def load_deployment_information(json_file_path):
    try:
        with open(json_file_path, 'r') as file:
            return json.load(file)
    except FileNotFoundError:
        print(f"Error: The file '{json_file_path}' was not found.")
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Error: Failed to decode JSON. Details: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python deploy.py <path_to_deployment_info_json>")
        sys.exit(1)

    json_file_path = sys.argv[1]
    deployment_info = load_deployment_information(json_file_path)
    run_commands(deployment_info)
