/**
 * @file Project list page
 * @author Mingze Ma
 */
import {useCallback, useEffect, useState} from "react";
import React from 'react';
import 'antd/dist/antd.css';
import moment from "moment";
import {
  Button,
  Progress,
  Modal,
  Table,
  Space,
  Drawer,
  Tag,
} from "antd";

import actions from "src/actions";
import _ from "lodash";
import {getProjectInfo} from "src/actions/projectActions";

import DrawerDetail from './ProjectDetail';
import {
  CheckCircleOutlined,
  ClockCircleOutlined,
  SyncOutlined
} from "@ant-design/icons";

// Column config of a table
// Using either dataIndex or key to point out unique props
const columnsConfig = (payloads) => {

  const {
    projectInfo,
    drawVisible,
    modalVisible,
    confirmLoading,
    modalText,
    showDrawer,
    onClose,
    showModal,
    handleOk,
    handleCancel,
  } = payloads;

  return [
    {
      title: 'Title',
      dataIndex: 'title',
      key: 'title',
      render: text => <a key={'title'}>{text}</a>,
      fixed: 'left',
      width: 150
    },
    {
      title: 'Introduction',
      dataIndex: 'intro',
      ellipsis: true,
      onCell: () => {
        return {
          style: {
            cursor: 'pointer'
          }
        }
      },
    },
    {
      title: 'Price',
      key: 'price',
      render: (text, record) => {
        const {price: price} = record;
        const realPrice = String(_.floor(price, 2));
        return (realPrice + _.get(projectInfo, 'currencyType'));
      }
    },
    {
      title: 'Donation Num',
      dataIndex: 'current_num',
    },
    {
      title: 'Total Num',
      dataIndex: 'total_num',
    },
    {
      title: 'Start Time',
      key: 'start_time',
      render: (text, record) => {
        const {start_time: startTime} = record;
        const timeOfStart = moment(startTime * 1000).format("YYYY-MM-DD");
        return timeOfStart;
      }
    },
    {
      title: 'End Time',
      key: 'end_time',
      render: (text, record) => {
        const {end_time: endTime} = record;
        const timeOfEnd = moment(endTime * 1000).format("YYYY-MM-DD");
        return timeOfEnd;
      }
    },
    {
      title: 'Region',
      dataIndex: 'region',
    },
    {
      title: 'Progress',
      key: 'Progress',
      render: (text, record) => {
        const {current_num: currentNum, total_num: totalNum} = record;
        const percent = _.floor((currentNum / totalNum) * 100, 0);
        return (
          <Progress percent={percent} type="circle" width={60}/>
        );
      }
    },
    {
      title: 'Tags',
      key: 'tags',
      render: (text, record) => {
        const {status: status} = record;
        switch (status) {
          case 0:
            return (
              <div>
                <Tag icon={<ClockCircleOutlined/>} color="warning">
                  Prepare
                </Tag>
              </div>
            );
          case 1:
            return (
              <div>
                <Tag icon={<SyncOutlined spin/>} color="processing">
                  Outgoing
                </Tag>
              </div>
            );
          case 2:
            return (
              <div>
                <Tag icon={<CheckCircleOutlined/>} color="success">
                  Complete
                </Tag>
              </div>
            );
        }
      }
    },
    {
      title: 'Action',
      key: 'action',
      width: 160,
      render: (text, record) => (
        <Space size="middle">
          <Button type="primary" onClick={() => showDrawer(record.pid)}>
            Detail
          </Button>
          <Button type="primary" onClick={() => showModal(record.pid)}>
            Stop
          </Button>
        </Space>
      ),
      fixed: 'right',
    },
  ];
}

export default () => {

  const [projectInfo, setProjectInfo] = useState({});

  const getProjectList = useCallback(async () => {
    try {
      const res = await actions.getProjectList()
      console.log('--res--\n', res);
      const {
        project_info: rawProjectInfo,
        page_info: pageInfo,
        currency_type: currencyType,
        ...otherProps
      } = res;
      const projectInfo = _.values(rawProjectInfo);
      console.log('--projectInfo--\n', projectInfo);
      const result = {
        ...otherProps,
        projectInfo,
        pageInfo,
        currencyType,
      };
      console.log('--result--\n', result);
      setProjectInfo(result);
    } catch (e) {
      console.error(e);
    }
  }, []);

  useEffect(() => {
    getProjectList().catch(err => console.error(err));
  }, [getProjectList]);

  // projectDetailInfo state
  const [projectDetailInfo, setProjectDetailInfo] = React.useState({});

  const [deleteProjectInfo, setDeleteProjectInfo] = React.useState(0);
  //project progress state
  const [progressStatus, setProgressStatus] = React.useState("exception");

  const [drawVisible, drawSetVisible] = React.useState(false);
  //Edit button
  const [modalVisible, modalSetVisible] = React.useState(false);
  const [confirmLoading, setConfirmLoading] = React.useState(false);
  const [modalText, setModalText] = React.useState('Are you sure you want to terminate the project. Terminated projects cannot be continued.');
  //Edit popup window
  const showDrawer = async (projectId) => {
    try {
      const res = await getProjectInfo({
        "pid": projectId,
        "currency_type": _.get(projectInfo, 'currencyType'),
      });
      console.log(res);
      setProjectDetailInfo(_.get(res,'project_info'));
      console.log(projectDetailInfo);
    } catch (error) {
      console.log(error);
    }
    drawSetVisible(true);
  };

  const onClose = () => {
    drawSetVisible(false);
  };
  //Below is the delete button pop-up warning box
  const showModal = async (projectId) => {
    try {
      const res = await getProjectInfo({
        "pid": projectId,
        "currency_type": _.get(projectInfo, 'currencyType'),
      });
      setDeleteProjectInfo(projectId);
    } catch (error) {
      console.log(error);
    }
    modalSetVisible(true);
  };

  const handleOk = () => {
    setModalText('Terminating project.');
    setConfirmLoading(true);
    actions.stopProject({
      "pid": deleteProjectInfo,
    });
    setTimeout(() => {
      modalSetVisible(false);
      setConfirmLoading(false);
    }, 2000);
  };

  const handleCancel = () => {
    console.log('Clicked cancel button');
    modalSetVisible(false);
  };
  const payloads = {
    projectInfo,
    drawVisible,
    modalVisible,
    confirmLoading,
    modalText,
    showDrawer,
    onClose,
    showModal,
    handleOk,
    handleCancel,
  };

  return (
    <div>
      <Table
        columns={columnsConfig(payloads)}
        rowKey={record => record.pid}
        dataSource={_.get(projectInfo, 'projectInfo', [])}
        scroll={{ x: 1400}}
      />
      <Drawer
        className='ffa-home'
        title="Project Detail Info"
        placement="right"
        onClose={onClose}
        zIndex={10000}
        visible={drawVisible}
        bodyStyle={{paddingBottom: 80}}
        width={600}
        extra={
          <Space>
            <Button onClick={onClose}>Cancel</Button>
          </Space>
        }>
        <DrawerDetail detailInfo={projectDetailInfo}/>
      </Drawer>
      <Modal
        title="Stop Project"
        visible={modalVisible}
        onOk={handleOk}
        confirmLoading={confirmLoading}
        onCancel={handleCancel}
      >
        <p>{modalText}</p>
      </Modal>
    </div>

  );

};
