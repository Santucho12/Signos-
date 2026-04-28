import re

with open(r'c:\Users\AMDRYZEN7\_\static\css\style-redesign.scss', 'r', encoding='utf-8') as f:
    content = f.read()

content = re.sub(r"'Oswald'", "'Blunt Semiconit'", content)
content = re.sub(r"'Montserrat'", "'Blunt Semiconit'", content)
content = re.sub(r"'Outfit'", "'Blunt Semiconit'", content)

with open(r'c:\Users\AMDRYZEN7\_\static\css\style-redesign.scss', 'w', encoding='utf-8') as f:
    f.write(content)

print("Done replacing fonts")
