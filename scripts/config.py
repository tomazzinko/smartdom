import argparse

import yaml

config_template = "./config.yaml"


def load_config(path):
    # load config file
    config = {}
    try:
        with open(path, "r") as file:
            # read yaml
            config = yaml.safe_load(file)
    except Exception as e:
        return None

    return config


def save_config(config, path):
    with open(path, "w") as file:
        yaml.dump(config, file)


def init_config(config_path):
    print(f"Config does not exist. Creating from template...")
    config = load_config(config_template)

    print(config)

    save_config(config, config_path)


def nested_exports(path, config):
    for key, value in config.items():
        p = f"{path}_{key}"
        if isinstance(value, dict):
            nested_exports(p, value)
        # if list make a csv
        elif isinstance(value, list):
            if isinstance(value[0], dict):
                for i, v in enumerate(value):
                    nested_exports(f"{p}_{i}", v)
            else:
                print(f'export {p.upper()}={",".join(value)}')
        else:
            if isinstance(value, str):
                value = value.strip()
            print(f"export {p.upper()}={value}")


def main():
    parser = argparse.ArgumentParser(description="Interface with config")
    parser.add_argument("config", help="Path to the config file.")
    args = parser.parse_args()

    config = load_config(args.config)

    # if config does not exist, create it
    if config is None:
        init_config(args.config)
    config = load_config(args.config)

    # export config
    nested_exports("smartdom", config)


if __name__ == "__main__":
    main()
