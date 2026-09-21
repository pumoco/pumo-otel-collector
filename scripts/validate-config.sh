#!/bin/sh
# Validate OTel collector config YAML syntax
python3 -c "
import yaml, sys
with open('otel-collector-config.yaml') as f:
    yaml.safe_load(f)
print('Config: valid YAML')
"