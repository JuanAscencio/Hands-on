import json

def valid_identifier(s):
    return s and s[0].isalpha() and all(c.isalnum() for c in s)

def validate_json(filename):
    try:
        with open(filename, "r") as f:
            data = json.load(f)
    except Exception as e:
        print("Error al leer JSON:", e)
        return False

    # Verificar clave "employees"
    if "employees" not in data:
        return False

    employees = data["employees"]
    if not isinstance(employees, list):
        return False

    for emp in employees:
        if not isinstance(emp, dict):
            return False
        # Verificar "firstName" y "lastName"
        for key in ["firstName", "lastName"]:
            if key not in emp or not isinstance(emp[key], str):
                return False
            if not valid_identifier(emp[key]):
                return False

    return True

if __name__ == "__main__":
    if validate_json("empleados.json"):
        print("JSON valido y aceptado por el DFA.")
    else:
        print("JSON invalido.")
