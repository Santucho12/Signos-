import re
import glob

files = glob.glob(r'c:\Users\AMDRYZEN7\_\**\*.scss', recursive=True)

for file in files:
    try:
        with open(file, 'r', encoding='utf-8') as f:
            content = f.read()

        new_content = re.sub(r"'Oswald'", "'Blunt Semiconit'", content)
        new_content = re.sub(r"'Montserrat'", "'Blunt Semiconit'", new_content)
        new_content = re.sub(r"'Outfit'", "'Blunt Semiconit'", new_content)
        
        # Also replace without quotes just in case
        new_content = re.sub(r"font-family:\s*Oswald", "font-family: 'Blunt Semiconit'", new_content)
        new_content = re.sub(r"font-family:\s*Montserrat", "font-family: 'Blunt Semiconit'", new_content)
        new_content = re.sub(r"font-family:\s*Outfit", "font-family: 'Blunt Semiconit'", new_content)

        if content != new_content:
            with open(file, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Replaced in {file}")
    except Exception as e:
        print(f"Error reading {file}: {e}")

print("Done replacing fonts")
