from hashlib import md5
from DataBase import models
import time
from Common.common import *

edit_user_info_status = {"success": 0,
                         "not_logged_in": 1,
                         "edit_fail": 2}

def gen_uid(seq=""):
    id = md5((str(time.time()) + seq).encode("utf-8")).hexdigest()
    if models.User.objects.filter(uid=id):
        id = gen_uid(seq=seq)
    return id

def create_user(create_info):
    param_list = ("mail", "password", "type", "region", "currency_type", "name", "avatar")
    if len(create_info) != len(param_list):
        return False
    for i in param_list:
        if i not in create_info:
            return False
    if create_info["type"] not in USER_TYPE.values():
        return False
    user_info = {"uid": "",
                 "project": "[]",
                 "regis_time": int(time.time()),
                 "last_login_time": int(time.time()),
                 "donate_history": "{}",
                 "share_mail_history": "[]"}
    user_info.update(create_info)
    user_info["region"] = region2rid(user_info["region"])
    if not user_info["region"]:
        return False
    user_info["currency_type"] = currency2cid(user_info["currency_type"])
    if not user_info["currency_type"]:
        return False
    if user_info["name"] == "":
        user_info["name"] = user_info["mail"]
    if user_info["avatar"] != "" and not os.path.isfile(os.path.join(IMG_DIR, os.path.basename(user_info["avatar"]))):
        user_info["avatar"] = ""
    user_info["uid"] = gen_uid(seq=user_info["mail"])
    return models.User.objects.create(**user_info)

def get_user(filter_dict):
    if len(filter_dict) != 1 or ("uid" not in filter_dict and "mail" not in filter_dict):
        return ""
    try:
        r = models.User.objects.get(**filter_dict)
        return r
    except:
        return ""

def update_user(user, update_dict):
    update_keys_list = ["mail", "password", "name", "avatar", "region", "currency_type", "last_login_time", "share_mail_history"]
    for key in update_dict.keys():
        if key not in update_keys_list:
            return False
    if "region" in update_dict:
        update_dict["region"] = region2rid(update_dict["region"])
        if not update_dict["region"]:
            return False
    if "currency_type" in update_dict:
        update_dict["currency_type"] = currency2cid(update_dict["currency_type"])
        if not update_dict["currency_type"]:
            return False
    try:
        for i in update_dict:
            user.__setattr__(i, update_dict[i])
        user.save(update_fields=list(update_dict.keys()))
        return True
    except:
        return False

def add_project(user, pid):
    project = eval(user.project)
    project.append(pid)
    user.project = str(project)
    user.save(update_fields=["project"])
    return True

def remove_project(user, pid):
    project = eval(user.project)
    if pid in project:
        project.remove(pid)
        user.project = str(project)
        user.save(update_fields=["project"])
    return True