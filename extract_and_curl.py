import re
import subprocess
import time

def extract_ip_from_inventory(inventory_file):
    with open(inventory_file, 'r') as file:
        content = file.read()

    # Регулярное выражение для извлечения IP-адреса из строки
    match = re.search(r'ansible_host=(\d+\.\d+\.\d+\.\d+)', content)
    if match:
        return match.group(1)
    else:
        raise ValueError("IP-адрес не найден в инвентори файле")

def check_service(ip_address):
    # Выполнение curl запроса на порт 8080
    response = subprocess.run(['curl', '-s', '-o', '/dev/null', '-w', '%{http_code}', f'http://{ip_address}:5601/login'], capture_output=True, text=True)
    return response.stdout.strip()

# Пример использования
inventory_file = 'ansible/inventories/inventory'
ip_address = extract_ip_from_inventory(inventory_file)
print(f"IP-адрес из инвентори файла: {ip_address}")
time.sleep(120)
http_code = check_service(ip_address)
print(f"HTTP код ответа: {http_code}")

# Возврат кода завершения для использования в Jenkins
if http_code == "200":
    exit(0)
else:
    exit(1)
