from DataBase.models import DProject
from DataBase.models import DUser
from datetime import datetime
from matplotlib import pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages
import time


class Statistics(object):
    @staticmethod
    def generate_report(id_):
        # External interface for generating PDF report.
        # Takes pid or uid.
        try:
            d = Statistics.get_project_dict(id_)
            pp = PdfPages('DOC/pdf_report/' + d['title'] + '.pdf')
            overall_sum, monthly_sum = Statistics.get_donation_sum(d)
            completeness = Statistics.get_completeness(d)
            region_dist = Statistics.get_region_distribution(d)

            fig = plt.figure()
            fig.clf()
            fig.text(0.5, 0.55,
                     'Food For All by Apex08',
                     fontsize=20, ha='center', va='center')
            fig.text(0.5, 0.4,
                     '- Project Report -',
                     fontsize=16, ha='center', va='center')
            pp.savefig(fig)

            fig = plt.figure()
            fig.clf()
            fig.text(0.1, 0.8,
                     'Project:    ' + d['title'],
                     fontsize=14, ha='left', va='center')
            fig.text(0.1, 0.7,
                     'Charity:    ' + d['charity'],
                     fontsize=14, ha='left', va='center')
            fig.text(0.1, 0.6,
                     'Location:    ' + d['region'],
                     fontsize=14, ha='left', va='center')
            fig.text(0.1, 0.5,
                     'Meal Price:    ' + str(round(d['price'], 2)) + ' GBP',
                     fontsize=14, ha='left', va='center')
            fig.text(0.1, 0.4,
                     'Progress:    ' + str(round(overall_sum, 2)) + ' / '
                     + str(round(d['total_num'] * d['price'], 2)) + ' GBP '
                     + '(' + str(round(completeness[1][-1]) * 100) + '%)',
                     fontsize=14, ha='left', va='center')
            fig.text(0.1, 0.3,
                     'Period:    ' + datetime.fromtimestamp(d['start_time']).strftime('%Y/%m/%d') + ' - '
                     + datetime.fromtimestamp(d['end_time']).strftime('%Y/%m/%d'),
                     fontsize=14, ha='left', va='center')
            fig.text(0.1, 0.2,
                     'Report Date:    ' + datetime.fromtimestamp(time.time()).strftime('%Y/%m/%d'),
                     fontsize=14, ha='left', va='center')
            pp.savefig(fig)

            x_iter = range(len(monthly_sum[0]))
            fig = plt.figure()
            plt.grid(axis="y")
            for x, y in zip(x_iter, monthly_sum[1]):
                plt.text(x, y, round(y, 2), ha='center', va='bottom')
            plt.title("Monthly Donation")
            plt.xticks(x_iter, monthly_sum[0], rotation=30)
            plt.ylabel('/GBP')
            plt.bar(x_iter, monthly_sum[1])
            pp.savefig(fig)

            x_iter = range(len(completeness[0]))
            fig = plt.figure()
            plt.grid(True)
            for x, y in zip(x_iter, completeness[1]):
                plt.text(x, y, round(y, 2), ha='left', va='top')
            plt.title("Project Completeness")
            plt.xticks(x_iter, completeness[0], rotation=30)
            plt.ylim(-0.1, 1.1)
            plt.plot(x_iter, completeness[1])
            pp.savefig(fig)

            fig = plt.figure()
            plt.title("Location Distribution")
            plt.pie(region_dist[1], labels=region_dist[0], autopct='%.2f%%')
            pp.savefig(fig)
        except AttributeError:
            d = Statistics.get_user_dict(id_)
            pp = PdfPages('DOC/pdf_report/' + d['name'] + '.pdf')
            overall_sum, monthly_sum = Statistics.get_donation_sum(d)
            region_dist = Statistics.get_region_distribution(d)

            fig = plt.figure()
            fig.clf()
            fig.text(0.5, 0.55,
                     'Food For All by Apex08',
                     fontsize=20, ha='center', va='center')
            fig.text(0.5, 0.4,
                     '- User Report -',
                     fontsize=16, ha='center', va='center')
            pp.savefig(fig)

            fig = plt.figure()
            fig.clf()
            fig.text(0.1, 0.8,
                     'User:    ' + d['name'] + (' (charity)' if d['type'] == 1 else ' (guest)'),
                     fontsize=14, ha='left', va='center')
            fig.text(0.1, 0.7,
                     'Email:    ' + d['mail'],
                     fontsize=14, ha='left', va='center')
            fig.text(0.1, 0.6,
                     'Location:    ' + d['region'],
                     fontsize=14, ha='left', va='center')
            fig.text(0.1, 0.5,
                     'Currency:    ' + d['currency_type'],
                     fontsize=14, ha='left', va='center')
            fig.text(0.1, 0.4,
                     'Total Donation:    ' + str(round(overall_sum, 2)) + ' GBP',
                     fontsize=14, ha='left', va='center')
            fig.text(0.1, 0.3,
                     'Registration Date:    ' + datetime.fromtimestamp(d['regis_time']).strftime('%Y/%m/%d'),
                     fontsize=14, ha='left', va='center')
            fig.text(0.1, 0.2,
                     'Report Date:    ' + datetime.fromtimestamp(time.time()).strftime('%Y/%m/%d'),
                     fontsize=14, ha='left', va='center')
            pp.savefig(fig)

            x_iter = range(len(monthly_sum[0]))
            fig = plt.figure()
            plt.grid(axis="y")
            for x, y in zip(x_iter, monthly_sum[1]):
                plt.text(x, y, round(y, 2), ha='center', va='bottom')
            plt.title("Monthly Donation")
            plt.xticks(x_iter, monthly_sum[0], rotation=30)
            plt.ylabel('/GBP')
            plt.bar(x_iter, monthly_sum[1])
            pp.savefig(fig)

            fig = plt.figure()
            plt.title("Location Distribution")
            plt.pie(region_dist[1], labels=region_dist[0], autopct='%.2f%%')
            pp.savefig(fig)
        pp.close()

    @staticmethod
    def get_completeness(project_dict):
        # Get monthly completeness of a project.
        # Returns completeness: [year-month_list, completeness_list].
        overall_sum, monthly_sum = Statistics.get_donation_sum(project_dict)
        current_sum = 0
        completeness = []
        for i in range(len(monthly_sum[1])):
            current_sum += monthly_sum[1][i]
            completeness.append(current_sum / project_dict['total_num'] / project_dict['price'])
        completeness = [monthly_sum[0], completeness]
        return completeness

    @staticmethod
    def get_donation_sum(d):
        # Get overall and monthly sum of donation.
        # For project: from start_time to this month. For user: from first donation to this month.
        # Takes project_dict or user_dict.
        # Returns overall_sum: int, monthly_sum: [year-month_list, sum_list].
        overall_sum = 0
        monthly_sum_dict = {}
        if 'pid' in d:
            for uid, sub_dict in d['donate_history'].items():
                for timestamp, num in sub_dict.items():
                    overall_sum += num * d['price']
                    ym = datetime.fromtimestamp(int(timestamp)).strftime('%Y%m')
                    if ym in monthly_sum_dict.keys():
                        monthly_sum_dict[ym] += num * d['price']
                    else:
                        monthly_sum_dict[ym] = num * d['price']
        else:
            for pid, sub_dict in d['donate_history'].items():
                price = Statistics.get_project_dict(pid)['price']
                if d['type'] == 1:
                    for uid, sub_sub_dict in sub_dict.items():
                        for timestamp, num in sub_sub_dict.items():
                            overall_sum += num * price
                            ym = datetime.fromtimestamp(int(timestamp)).strftime('%Y%m')
                            if ym in monthly_sum_dict.keys():
                                monthly_sum_dict[ym] += num * price
                            else:
                                monthly_sum_dict[ym] = num * price
                else:
                    for timestamp, num in sub_dict.items():
                        overall_sum += num * price
                        ym = datetime.fromtimestamp(int(timestamp)).strftime('%Y%m')
                        if ym in monthly_sum_dict.keys():
                            monthly_sum_dict[ym] += num * price
                        else:
                            monthly_sum_dict[ym] = num * price
        monthly_sum = sorted(monthly_sum_dict.items(), key=lambda x: x[0])
        if 'pid' in d:
            start_ym = datetime.fromtimestamp(d['start_time']).strftime('%Y%m')
        else:
            start_ym = monthly_sum[0][0]
        end_ym = datetime.fromtimestamp(time.time()).strftime('%Y%m')
        ym_list = []
        sum_list = []
        for ym in range(int(start_ym), int(end_ym) + 1):
            if 1 <= int(str(ym)[-2:]) <= 12:
                ym_list.append(ym)
                sum_list.append(monthly_sum_dict[str(ym)] if str(ym) in monthly_sum_dict else 0)
        monthly_sum = [ym_list, sum_list]
        return overall_sum, monthly_sum

    @staticmethod
    def get_project_dict(pid):
        dproject = DProject()
        project = dproject.get_project({"pid": pid})
        return project.to_dict()

    @staticmethod
    def get_region_distribution(d):
        # Get region distribution of donation.
        # Returns region_dist: [region_list, ratio_list].
        region_dist_dict = {}
        if 'pid' in d:
            for uid, sub_dict in d['donate_history'].items():
                user_dict = Statistics.get_user_dict(uid)
                region = user_dict['region']
                user_num_sum = 0
                for timestamp, num in sub_dict.items():
                    user_num_sum += num
                user_ratio = user_num_sum / d['current_num']
                if region in region_dist_dict.keys():
                    region_dist_dict[region] += user_ratio
                else:
                    region_dist_dict[region] = user_ratio
        else:
            if d['type'] == 1:
                projects_sum = 0
                for pid, sub_dict in d['donate_history'].items():
                    project_dict = Statistics.get_project_dict(pid)
                    projects_sum += project_dict['current_num'] * project_dict['price']
                    for uid, sub_sub_dict in sub_dict.items():
                        user_dict = Statistics.get_user_dict(uid)
                        region = user_dict['region']
                        user_sum = 0
                        for timestamp, num in sub_sub_dict.items():
                            user_sum += num * project_dict['price']
                        if region in region_dist_dict.keys():
                            region_dist_dict[region] += user_sum
                        else:
                            region_dist_dict[region] = user_sum
                for key in region_dist_dict.keys():
                    region_dist_dict[key] = region_dist_dict[key] / projects_sum
            else:
                overall_sum, monthly_sum = Statistics.get_donation_sum(d)
                for pid, sub_dict in d['donate_history'].items():
                    project_dict = Statistics.get_project_dict(pid)
                    region = Statistics.get_user_dict(project_dict['uid'])['region']
                    project_num_sum = 0
                    for timestamp, num in sub_dict.items():
                        project_num_sum += num
                    project_ratio = project_num_sum * project_dict['price'] / overall_sum
                    if region in region_dist_dict.keys():
                        region_dist_dict[region] += project_ratio
                    else:
                        region_dist_dict[region] = project_ratio
        region_dist = sorted(region_dist_dict.items(), key=lambda x: x[1], reverse=True)
        region_list, ratio_list = zip(*region_dist)
        region_dist = [region_list, ratio_list]
        return region_dist

    @staticmethod
    def get_user_dict(uid):
        duser = DUser()
        user = duser.get_user({"uid": uid})
        return user.to_dict()
