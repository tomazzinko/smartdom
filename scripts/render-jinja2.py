import os
import argparse
import shutil
from jinja2 import Environment, FileSystemLoader, pass_context

from secrets import secret_macro, password_macro, set_secrets_file
from config import load_config
from zigbee2mqtt import generate_pan_id, generate_ext_pan_id, generate_network_key

secrets_file = 'secrets.yaml'

def render_template(template_path, config_values, output_path):
    """Render the Jinja2 template and save the result to the output path."""
    env = Environment(loader=FileSystemLoader(os.path.dirname(template_path)))
    template = env.get_template(os.path.basename(template_path))

    # macros
    env.globals['secret'] = secret_macro
    env.globals['password'] = password_macro

    env.globals['gen_pan_id'] = generate_pan_id
    env.globals['gen_ext_pan_id'] = generate_ext_pan_id
    env.globals['gen_network_key'] = generate_network_key

    # Render the template with the environment variables
    output = template.render(config_values)

    # Ensure the output directory exists
    output_dir = os.path.dirname(output_path)
    os.makedirs(output_dir, exist_ok=True)

    # Write the output to the corresponding file
    with open(output_path, 'w') as f:
        f.write(output)

def process_directory(input_dir, output_dir, config_values):
    """Process all files in the input directory, rendering templates and copying others."""
    for root, dirs, files in os.walk(input_dir):
        for file in files:
            file_path = os.path.join(root, file)
            relative_path = os.path.relpath(file_path, input_dir)
            
            if file.endswith(".j2"):
                print(f'Processing {relative_path}...')
                output_path = os.path.join(output_dir, relative_path[:-3])
                render_template(file_path, config_values, output_path)
            else:
                print(f'Copying {relative_path}...')
                output_path = os.path.join(output_dir, relative_path)
                os.makedirs(os.path.dirname(output_path), exist_ok=True)
                shutil.copy2(file_path, output_path)

def main():
    # Parse command-line arguments
    parser = argparse.ArgumentParser(description='Generate configuration files from a directory of Jinja2 templates and environment variables.')
    parser.add_argument('config', help='Config file.')
    parser.add_argument('secrets', help='Secrets file.')
    parser.add_argument('input_template_dir', help='Path to the directory containing Jinja2 templates.')
    parser.add_argument('output_dir', help='Path to the output directory.')
    args = parser.parse_args()

    set_secrets_file(args.secrets)

    print(f'Generating configuration files from {args.input_template_dir} to {args.output_dir}...')

    config = load_config(args.config)

    # Process all templates in the input directory
    process_directory(args.input_template_dir, args.output_dir, config)

if __name__ == "__main__":
    main()
