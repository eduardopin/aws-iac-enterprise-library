fmt:
	terraform fmt -recursive

hygiene:
	python3 tools/module_hygiene_check.py

safety:
	bash tools/public_safety_audit.sh

quality: fmt hygiene safety
