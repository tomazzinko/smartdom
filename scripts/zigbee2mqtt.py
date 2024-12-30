import random

def generate_hex_value(length):
    return ''.join(random.choice('0123456789ABCDEF') for _ in range(length))

def generate_pan_id():
    return '0x' + generate_hex_value(4)

def generate_ext_pan_id():
    return '[' + ', '.join('0x' + generate_hex_value(2) for _ in range(8)) + ']'

def generate_network_key():
    return '[' + ', '.join('0x' + generate_hex_value(2) for _ in range(16)) + ']'

def generate_parameters():
    Z2M_ADVANCED_PAN_ID = generate_pan_id()
    Z2M_ADVANCED_EXT_PAN_ID = generate_ext_pan_id()
    Z2M_ADVANCED_NETWORK_KEY = generate_network_key()
    
    return {
        'Z2M_ADVANCED_PAN_ID': Z2M_ADVANCED_PAN_ID,
        'Z2M_ADVANCED_EXT_PAN_ID': Z2M_ADVANCED_EXT_PAN_ID,
        'Z2M_ADVANCED_NETWORK_KEY': Z2M_ADVANCED_NETWORK_KEY
    }

if __name__ == "__main__":
    parameters = generate_parameters()
    for key, value in parameters.items():
        print(f'{key}={value}')
