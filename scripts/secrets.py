import os

import yaml

global secrets_file

def set_secrets_file(path):
    global secrets_file
    secrets_file = path

def get_secret(name):
    # load secrets file 
    secrets = {}
    with open(secrets_file, 'r') as file:
        # read yaml
        secrets = yaml.safe_load(file)

    if secrets is None:
        return None

    if name not in secrets:
        return None
    
    return secrets[name]

def set_secret(name, value):
    # load secrets file 
    secrets = {}
    with open(secrets_file, 'r') as file:
        # read yaml
        secrets = yaml.safe_load(file)

    if secrets is None:
        secrets = {}
    
    # set value
    secrets[name] = value

    # write secrets file
    with open(secrets_file, 'w') as file:
        # write yaml
        yaml.dump(secrets, file)

# password macro
def password_macro(name):
    password = get_secret(name)
    
    if password is not None:
        return password
    
    # generate a secure password
    password = os.urandom(16).hex()
    
    # store the password
    set_secret(name, password)
    
    return password

def secret_macro(name, default=None):
    if not os.path.exists(secrets_file):
        with open(secrets_file, 'w') as file:
            config = {}
            yaml.dump(config, file)

    secret = get_secret(name)
    
    if secret is not None:
        return secret
    
    if default is not None:
        # is fn?
        if callable(default):
            secret = default()
        else:
            secret = default

    # store the secret
    set_secret(name, secret)
    
    return secret


def main():
    pass

if __name__ == "__main__":
    main()
