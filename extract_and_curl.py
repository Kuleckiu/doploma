import re
import subprocess
import time

def extract_ip_from_inventory(inventory_file):
    with open(inventory_file, 'r') as file:
        content = file.read()

    # A regular expression for extracting an IP address from a string
    match = re.search(r'ansible_host=(\d+\.\d+\.\d+\.\d+)', content)
    if match:
        return match.group(1)
    else:
        raise ValueError("IP-адрес не найден в инвентори файле")

def check_service(ip_address):
    # Executing a curl request 
    response = subprocess.run(['curl', '-s', '-o', '/dev/null', '-w', '%{http_code}', f'http://{ip_address}:5601/login'], capture_output=True, text=True)
    return response.stdout.strip()

# Usage example
# inventory_file = 'ansible/inventories/inventory'
# ip_address = extract_ip_from_inventory(inventory_file)
# print(f"IP-the address from the file inventory: {ip_address}")
# # time.sleep(160)
# http_code = check_service(ip_address)
# print(f"HTTP response code: {http_code}")

# Return the completion code for use in Jenkins
# if http_code == "200":
#     exit(0)
# else:
#     time.sleep(10)
#     http_code = check_service(ip_address)
#     print(f"HTTP response code: {http_code}")
def main():
    inventory_file = 'ansible/inventories/inventory'
    ip_address = extract_ip_from_inventory(inventory_file)
    print(f"IP-адрес из инвентори файла: {ip_address}")

    while True:
        http_code = check_service(ip_address)
        print(f"HTTP response code: {http_code}")
        if http_code == "200":
            exit(0)
        else:
            print("Сервис недоступен. Повторная проверка через 10 секунд...")
            time.sleep(10)

if __name__ == "__main__":
    main()