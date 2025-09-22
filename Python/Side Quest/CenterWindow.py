# Para hindi na idagdag ng paulit-uli sa code lamaw
# Bakit parang 100 times na mas madali ang Python kesa sa Java?
# Anyways para to sa pag center ng window sa screen

# Pano gagamitin?
# 1. Import mo lang siya sa ibang file
    # import CenterWindow
# 2. Tawagin mo lang yung function na center_window at ipasa mo yung root window at optional width at height
    # CenterWindow.center_window(root, 400, 200)

# Naka default siya sa 300x100 kung hindi mo ipapasa yung width at height
def center_window(root, width=300, height=100):
    screen_width = root.winfo_screenwidth()
    screen_height = root.winfo_screenheight()
    x = (screen_width // 2) - (width // 2)
    y = (screen_height // 2) - (height // 2)
    root.geometry(f"{width}x{height}+{x}+{y}")
    root.resizable(False, False) 