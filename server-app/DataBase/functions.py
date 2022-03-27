from .models import *
from faker import Faker
import random
import requests
from collections import Counter
import copy
import shutil
import hashlib
from django.contrib.auth.hashers import make_password

random.seed(int(time.time()))
Faker.seed(int(time.time()))
fk = Faker(locale = 'en')

resource_file = {"avatar": [i for i in os.listdir(os.path.join(RESOURCE_DIR, "avatar")) if i.endswith(".jpg")],
                 "background_image": [i for i in os.listdir(os.path.join(RESOURCE_DIR, "background_image")) if i.endswith(".jpg")]}

def clear_database():
    DUser.objects.all().delete()
    DProject.objects.all().delete()
    img_path_list = os.listdir(IMG_DIR)
    for i in img_path_list:
        if os.path.isfile(os.path.join(IMG_DIR, i)) and i.endswith(".jpg"):
            os.remove(os.path.join(IMG_DIR, i))

def get_random_avatar(num=100, size=256, path=os.path.join(RESOURCE_DIR, "avatar")):
    styles = ['identicon', 'monsterid', 'wavatar']
    for i in range(num):
        random_str = ''.join([chr(random.randint(0x0000, 0x9fbf)) for i in range(random.randint(1, 25))])
        m1 = hashlib.md5("{}".format(random_str).encode("utf-8")).hexdigest()
        url = 'http://www.gravatar.com/avatar/{}?s={}&d={}'.format(m1, size, random.choice(styles))
        res = requests.get(url)
        with open(os.path.join(path, str(i) + '.jpg'), 'wb') as f:
            f.write(res.content)

def download_random_img(shape=(160, 160), path=IMG_DIR):
    if type(shape) == int:
        shape = (shape, shape)
    img_url = "https://placeimg.com/{s0}/{s1}/any".format(s0=str(shape[0]), s1=str(shape[1]))
    header = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36'}
    name = "".join(fk.random_letters(4)) + ".jpg"
    while os.path.isfile(os.path.join(path, name)):
        name = "".join(fk.random_letters(4)) + ".jpg"
    r = requests.get(img_url, headers=header, stream=True)
    if r.status_code == 200:
        with open(os.path.join(path, name), 'wb') as f:
            f.write(r.content)
    return os.path.join(STATIC_URL, name)

def copy_random_img(img_type, path=IMG_DIR):
    name = "".join(fk.random_letters(8)) + ".jpg"
    while os.path.isfile(os.path.join(path, name)):
        name = "".join(fk.random_letters(8)) + ".jpg"
    if img_type in ("avatar", "background_image"):
        shutil.copyfile(os.path.join(RESOURCE_DIR, img_type, random.choice(resource_file[img_type])), os.path.join(path, name))
    else:
        return ""
    return os.path.join(STATIC_URL, name)

def create_fake_user(user_type_list=(USER_TYPE["charity"], USER_TYPE["guest"])):
    password_ori = fk.password()
    fake_user = {"uid": "",
                 "mail": fk.safe_email(),
                 "password": make_password(password_ori),
                 "name": "",
                 "avatar": "" if random.choices([0, 1], weights=[10, 1], k=1)[0] else copy_random_img("avatar"),#download_random_img(random.randint(100, 200)),
                 "type": random.choice(user_type_list),
                 "region": random.choice(list(RID2REGION.keys())),
                 "currency_type": random.choice(list(CID2CURRENCY.keys())),
                 "project": "[]",
                 "regis_time": int(time.time()) - random.randint(30 * 24 * 60 * 60, 365 * 24 * 60 * 60),
                 "last_login_time": int(time.time()) - random.randint(0, 24 * 60 * 60),
                 "donate_history": "{}",
                 "share_mail_history": str([fk.safe_email(), fk.safe_email()])}
    fake_user["uid"] = DUser.gen_uid(fake_user["mail"])
    if fake_user["type"] == USER_TYPE["charity"]:
        fake_user["name"] = fk.company()
    else:
        fake_user["name"] = fk.name()
    try:
        DUser.objects.create(**fake_user)
        return fake_user["uid"], fake_user["mail"], password_ori, fake_user["type"]
    except:
        return create_fake_user(user_type_list=user_type_list)

def create_fake_project(uid, donate_history):
    donate_history = copy.deepcopy(donate_history)
    user = DUser.get_user({"uid": uid})
    fake_project = {"pid": DProject.gen_pid(user.mail),
                    "uid": user.uid,
                    "title": "",
                    "intro": "",
                    "region": user.region,
                    "charity": user.name,
                    "charity_avatar": user.avatar,
                    "background_image": "" if random.choices([0, 1], weights=[10, 1], k=1)[0] else copy_random_img("background_image"),#download_random_img((int(img_height * (random.random() + 1.5)), random.randint(300, 600)))
                    "total_num": random.randint(10, 30) * 10,
                    "current_num": "",
                    "start_time": "",
                    "end_time": "",
                    "details": "",
                    "price": random.random() * 1.5 + 1.5,
                    "donate_history": "{}",
                    "status": random.choices(list(PROJECT_STATUS.values()), weights=[2, 12, 6], k=1)[0]}
    content = fk.texts(random.randint(3, 8))
    fake_project["title"] = content[0][:random.randint(30, 50)]
    fake_project["intro"] = content[0]
    fake_project["details"] = "\n".join(content)
    project_donate_dict = {}
    if fake_project["status"] == PROJECT_STATUS["prepare"]:
        fake_project["current_num"] = 0
        fake_project["start_time"] = 0
        fake_project["end_time"] = int(time.time()) + random.randint(30 * 24 * 60 * 60, 365 * 24 * 60 * 60)
        fake_project["donate_history"] = "{}"
    elif fake_project["status"] == PROJECT_STATUS["finish"]:
        fake_project["start_time"] = random.randint(user.regis_time, int(time.time()) - 30 * 24 * 60 * 60)
        fake_project["end_time"] = random.randint(fake_project["start_time"] + 5 * 24 * 60 * 60, fake_project["start_time"] + 365 * 24 * 60 * 60)
        if fake_project["end_time"] < int(time.time()):
            fake_project["current_num"] = random.randint(0, fake_project["total_num"])
        else:
            fake_project["current_num"] = fake_project["total_num"]
        donor_dict = Counter(random.choices(list(donate_history.keys()), k=fake_project["current_num"]))
        for donor_uid in donor_dict:
            donor_times = random.randint(1, donor_dict[donor_uid])
            donor_counts = random.sample(list(range(1, donor_dict[donor_uid])), donor_times - 1)
            donor_counts.append(0)
            donor_counts.append(donor_dict[donor_uid])
            donor_counts.sort()
            donor_counts = [i - j for i, j in zip(donor_counts[1:], donor_counts[:-1])]
            donor_time = []
            t = max(user.regis_time, fake_project["start_time"])
            for i in range(donor_times):
                t = random.randint(t, t + (fake_project["end_time"] - t) // (donor_times - i))
                donor_time.append(t)
            project_donate_dict[donor_uid] = {}
            for i in range(donor_times):
                project_donate_dict[donor_uid][str(donor_time[i])] = donor_counts[i]
            donate_history[donor_uid][fake_project["pid"]] = project_donate_dict[donor_uid]
        fake_project["donate_history"] = str(project_donate_dict)
    elif fake_project["status"] == PROJECT_STATUS["ongoing"]:
        fake_project["current_num"] = random.randint(0, fake_project["total_num"] - 1)
        fake_project["start_time"] = random.randint(user.regis_time, int(time.time()) - 30 * 24 * 60 * 60)
        fake_project["end_time"] = random.randint(int(time.time()) + 5 * 24 * 60 * 60, int(time.time()) + 365 * 24 * 60 * 60)
        donor_dict = Counter(random.choices(list(donate_history.keys()), k=fake_project["current_num"]))
        for donor_uid in donor_dict:
            donor_times = random.randint(1, donor_dict[donor_uid])
            donor_counts = random.sample(list(range(1, donor_dict[donor_uid])), donor_times - 1)
            donor_counts.append(0)
            donor_counts.append(donor_dict[donor_uid])
            donor_counts.sort()
            donor_counts = [i - j for i, j in zip(donor_counts[1:], donor_counts[:-1])]
            donor_time = []
            t = max(user.regis_time, fake_project["start_time"])
            for i in range(donor_times):
                t = random.randint(t, t + (int(time.time()) - t) // (donor_times - i))
                donor_time.append(t)
            project_donate_dict[donor_uid] = {}
            for i in range(donor_times):
                project_donate_dict[donor_uid][str(donor_time[i])] = donor_counts[i]
            donate_history[donor_uid][fake_project["pid"]] = project_donate_dict[donor_uid]
        fake_project["donate_history"] = str(project_donate_dict)
    DProject.objects.create(**fake_project)
    user.add_project_to_list(fake_project["pid"])
    if project_donate_dict:
        user_donate_history = eval(user.donate_history)
        user_donate_history[fake_project["pid"]] = project_donate_dict
        user.donate_history = str(user_donate_history)
        user.save(update_fields=["donate_history"])
    return donate_history

def init_database_with_fake_data(user_num=50, project_num=200):
    for _ in range(5):
        clear_database()
        guest_list = []
        charity_list = []
        fake_user_info = [["uid", "username", "password", "type"]]
        for _ in range(user_num):
            fake_user_uid, fake_user_mail, fake_user_password, fake_user_type = create_fake_user(user_type_list=(USER_TYPE["charity"], USER_TYPE["guest"]))
            if fake_user_type == USER_TYPE["charity"]:
                charity_list.append(fake_user_uid)
            else:
                guest_list.append(fake_user_uid)
            fake_user_info.append([fake_user_uid, fake_user_mail, fake_user_password, fake_user_type])
        if len(guest_list) != 0 and len(charity_list) != 0:
            break
    owner_list = random.choices(charity_list, k=project_num)
    donate_history = {}
    for i in guest_list:
        donate_history[i] = {}
    for i in range(project_num):
        donate_history = create_fake_project(owner_list[i], donate_history)
    for donor_uid in donate_history:
        user = DUser.get_user({"uid": donor_uid})
        user.donate_history = str(donate_history[donor_uid])
        user.project = str(list(donate_history[donor_uid].keys()))
        user.save(update_fields=["project", "donate_history"])
    return fake_user_info