from .functions import Statistics
from Common.decorators import *


@api_logger_decorator()
@check_server_error_decorator()
@check_request_method_decorator(method=["POST"])
@get_user_decorator()
def get_stat(request, user):
    """
    @api {POST} /get_stat/ get statistics data
    @apiVersion 1.0.0
    @apiName get_stat
    @apiGroup Statistics
    @apiDescription Get statistics data for frontend dashboard

    @apiParam {String} pid Leave blank to get data of the current user or specify a pid of any affiliated project.

    @apiSuccess (Success 200 return) {Int} status Status code ([0] success, [100001] user has not logged in, [200002] project does not exist, [200003] user is not the owner of the project)
    @apiSuccess (Success 200 return) {Dict} stat Statistics data.
    @apiSuccess (Success 200 return) {Int} overall_sum Overall sum of donation.
    @apiSuccess (Success 200 return) {Dict} monthly_sum Monthly sum of donation.
    @apiSuccess (Success 200 return) {Dict} Monthly progress of a project.
    @apiSuccess (Success 200 return) {Dict} Regional distribution of donation.

    @apiParamExample {Json} Sample Request
    {
      "pid": ""
    }
    @apiSuccessExample {Json} Response-Success
    {
        "status": 0,
        "stat": {
            "overall_sum": 2325.8058573595813,
            "monthly_sum": {
                "202110": 25.38635395622341,
                "202111": 83.94399337200952,
                "202112": 174.35017007224477,
                "202201": 269.812925171546,
                "202202": 560.2525941802537,
                "202203": 663.5475702441728,
                "202204": 259.78657985690444,
                "202205": 145.51878109829747
            },
            "progress": {},
            "regional_dist": {
                "": 0.1595509712334177,
                "Moldova, Republic of Moldova": 0.089812277796986,
                "Latvia": 0.05986185261846537,
                "Sri Lanka": 0.05946180316420208,
                "Dominica": 0.04336329633300498,
                "Spain": 0.03903952285678018,
                "Kiribati": 0.03757099035058154,
                "Madagascar": 0.03747727290665375,
                "Tonga": 0.036527191556695385,
                "Papua New Guinea": 0.035626688941039514,
                "Maldives": 0.03552259256316131,
                "Turkmenistan": 0.03519085713041302,
                "Denmark": 0.03493706048536908,
                "Antigua and Barbuda": 0.03418927440330687,
                "South Korea": 0.03195128590088027,
                "Hungary": 0.03193212530391174,
                "Palau": 0.02900629702106567,
                "Saint Helena, Ascension, and Tristan da Cunha": 0.028371282169266574,
                "Switzerland": 0.02687954360632756,
                "Montserrat": 0.024853387741580555,
                "Virgin (British) Islands": 0.023592879304021815,
                "Kazakhstan": 0.023318368481816006,
                "St. Lucia": 0.021326717636390324,
                "Jamaica": 0.020636460494662803
            }
        }
    }
    """
    data = json.loads(request.body)
    pid = data['pid']
    op = data['op']
    days = 0
    if op == 'monthly':
        days = 30
    elif op == 'weekly':
        days = 7
    elif op == 'all':
        days = 0
    elif op == 'half month':
        days = 15
    if pid:
        project = DProject.get_project({'pid': pid})
        if not project:
            raise ServerError("project does not exist")
        if user.uid != project.uid:
            raise ServerError("user is not the owner of the project")
        d = Statistics.get_project_dict(pid)
    else:
        d = Statistics.get_user_dict(user.uid)
    # progress = Statistics.get_progress(d) if pid else {}
    time_line = Statistics.get_time_line(d)
    regional_dist = Statistics.m_get_regional_dist(d)
    project_name = Statistics.get_project_name(d)
    progress = Statistics.get_monthly_progress(d, days)
    # stat = {'overall_sum': overall_sum,
    #         'monthly_sum': dict(zip(monthly_sum[0], monthly_sum[1])),
    #         'progress': dict(zip(progress[0], progress[1])) if pid else {},
    #         'regional_dist': dict(zip(regional_dist[0], regional_dist[1]))}
    progress_data = []
    if len(regional_dist[0]) < 8:
        for name, value in zip(regional_dist[0], regional_dist[1]):
            progress_data.append({'value': "%.2f" % value, 'name': name})
    else:
        i = 0;
        other_value = 0
        for name, value in zip(regional_dist[0], regional_dist[1]):
            if i < 8:
                progress_data.append({'value': "%.2f" % value, 'name': name})
                i += 1
            else:
                other_value += value
        progress_data.append({'value': "%.2f" % other_value, 'name': 'Others'})

    final_date = time_line[-days:]
    final_progress = progress
    final_history = Statistics.get_history(d, days)


    stat = {
        '0': {
            'title': {
                'text': 'Donation Line'
            },
            'tooltip': {
                'trigger': 'axis'
            },
            'legend': {
                'data': project_name
            },
            'grid': {
                'left': '3%',
                'right': '4%',
                'bottom': '3%',
                'containLabel': 'true'
            },
            'toolbox': {
                'feature': {
                    'saveAsImage': {}
                }
            },
            'xAxis': {
                'type': 'category',
                'boundaryGap': 'false',
                'data': final_date
            },
            'yAxis': {
                'type': 'value',
                'axisLabel': {
                    'show': 'true',
                    'formatter': '{value}%',
                },
                'show': 'true'
            },
            'series': final_progress
        },
        '1': {
            'title': {
                'text': 'Donation Location',
                'left': 'center'
            },
            'tooltip': {
                'trigger': 'item'
            },
            'legend': {
                'type': 'scroll',
                'orient': 'vertical',
                'left': 'left'
            },
            'series': [
                {
                    'name': 'Access From',
                    'type': 'pie',
                    'radius': '50%',
                    'data': progress_data,
                    'emphasis': {
                        'itemStyle': {
                            'shadowBlur': 10,
                            'shadowOffsetX': 0,
                            'shadowColor': 'rgba(0, 0, 0, 0.5)'
                        }
                    }

                }
            ]
        },
        '2': {
            'title': {
                'text': 'Donation History'
            },
            'tooltip': {
                'trigger': 'axis',
                'axisPointer': {
                    'type': 'shadow'
                }
            },
            'legend': {},
            'grid': {
                'left': '3%',
                'right': '4%',
                'bottom': '3%',
                'containLabel': 'true'
            },
            'xAxis': {
                'type': 'value'
            },
            'yAxis': {
                'type': 'category',
                'data': final_date
            },
            'series': final_history
        }

    }
    response_data = {'status': STATUS_CODE['success'], 'stat': stat}
    return HttpResponse(json.dumps(response_data), content_type='application/json')


@api_logger_decorator()
@check_server_error_decorator()
@check_request_method_decorator(method=["POST"])
@get_user_decorator()
def get_report(request, user):
    """
    @api {POST} /get_report/ get statistics pdf report
    @apiVersion 1.0.0
    @apiName get_report
    @apiGroup Statistics
    @apiDescription api to get statistics pdf report

    @apiParam {String} pid Leave blank to get report of the current user or specify a pid of any affiliated project.

    @apiSuccess (Success 200 return) {Int} status Status code ([0] success, [100001] user has not logged in, [200002] project does not exist, [200003] user is not the owner of the project)
    @apiSuccess (Success 200 return) {String} url URL of report.

    @apiParamExample {Json} Sample Request
    {
      "pid": "adfasdfasdfasdsf"
    }
    @apiSuccessExample {Json} Response-Success
    {
        'status': 0
        "url": "static/p_adfasdfasdfasdsf.pdf"
    }
    """
    data = json.loads(request.body)
    pid = data['pid']
    if pid:
        project = DProject.get_project({'pid': pid})
        if not project:
            raise ServerError("project does not exist")
        if user.uid != project.uid:
            raise ServerError("user is not the owner of the project")
        filename = Statistics.get_project_report(pid)
    else:
        filename = Statistics.get_user_report(user.uid)
    response_data = {'status': STATUS_CODE['success'], 'url': os.path.join(STATIC_URL, filename)}
    return HttpResponse(json.dumps(response_data), content_type='application/json')
