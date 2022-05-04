/**
 * @file share and payment success page
 * @author Mingze Ma
 */

// module import
import {useEffect, useMemo, useState} from 'react';
import {useLocation} from 'react-router-dom';
import _ from 'lodash';

// style import
import './index.less';
import Box from "@mui/material/Box";
import Typography from '@mui/material/Typography';
import Button from "@mui/material/Button";
import * as React from "react";
import {Image, Switch} from "antd";
import success from 'src/assets/success.jpg'
import {Checkbox, FormControlLabel, FormGroup, TextField} from "@mui/material";
import {Result} from 'antd';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogTitle from '@mui/material/DialogTitle';
import actions from "src/actions";

export default (props) => {

    const location = useLocation();

    const [sharedProject, setSharedProject] = useState(null);

    //Set Dialog Status
    const [open, setOpen] = React.useState(false);
    const [dialogText, setDialogText] = useState('');

    const handleClickOpen = async (event) => {
        const data = new FormData(event.currentTarget);
        console.log({
            email01: data.get('email01'),
            email02: data.get('email02'),
            hide: data.get('hide'),
        });
        if (data.get('email01') === '' && data.get('email02') === ''){
            setDialogText("Are you sure you don't want to share the project with others?")
        }else {
            setDialogText("Thank you for sharing。")
        }
        setOpen(true);
        event.preventDefault();


        let hideStatus = 0;
        if (data.get('hide') === 'on')
            hideStatus = 1;
        await actions.shareByEmail({
            "mail": [data.get('email01'), data.get('email02')],
            "project_name": _.get(sharedProject, 'title'),
            "project_url": "http://127.0.0.1:3000/donation/"+_.get(sharedProject,'pid'),
            "donate_num": _.get(sharedProject, 'current_num'),
            "if_hide_personal_information": hideStatus,
            "user_name": _.get(sharedProject, 'uid')
        });
    };

    const handleClose = () => {
        setOpen(false);
    };
    const handleOk = () => {

    }

    useEffect(() => {
        const pid = _.get(location, 'state.pid', null);
        if (!pid) {
            return;
        }
        (async () => {
            const res = await actions.getProjectInfo({
                'pid': pid,
                'currency_type': "GBP"
            });
            setSharedProject(_.get(res, 'project_info'));
        })();
    }, []);

    const projectId = _.get(location, 'state.pid', null);
    return (
        <div align="center">
            {
                projectId
                    ? sharedProject && <div>
                        <Box align="center" textAlign="center"
                             sx={{width: '100%', maxWidth: 500}}>
                            <img src={success} alt="success"/>
                            <Typography variant="h5" component="div" gutterBottom>
                                You have successfully donated!
                            </Typography>
                            <Typography variant="h5" component="div" gutterBottom>
                                Thank you very much. We hope you will be able to share this project with more people.
                            </Typography>
                        </Box>
                        <Box
                            component="form"
                            sx={{
                                width: '100ch',
                                '& > :not(style)': {m: 1, width: '40ch'},
                            }}
                            noValidate
                            autoComplete="off"
                            alignItems={"center"}
                            onSubmit={handleClickOpen}
                        >
                            <TextField name="email01" label="email" variant="outlined"/>
                            <TextField name="email02" label="email" variant="outlined"/>
                            <Box alignContent={"center"}>
                                <FormGroup>
                                    <FormControlLabel name="hide" control={<Checkbox defaultChecked/>}
                                                      label=" Hide personal information in emails"/>
                                </FormGroup>
                            </Box>
                            <Button type="submit" size="large" variant="outlined" onClick={handleClickOpen}>Confirm</Button>
                            <Dialog
                                open={open}
                                onClose={handleClose}
                                aria-labelledby="alert-dialog-title"
                                aria-describedby="alert-dialog-description"
                                maxWidth='sm'
                                fullWidth={true}
                            >
                                <DialogTitle id="alert-dialog-title">
                                    {"Share"}
                                </DialogTitle>
                                <DialogContent>
                                    <DialogContentText id="alert-dialog-description">
                                        {dialogText}
                                    </DialogContentText>
                                </DialogContent>
                                <DialogActions>
                                    <Button onClick={handleClose}>Cancel</Button>
                                    <Button onClick={handleOk} autoFocus>
                                        Ok
                                    </Button>
                                </DialogActions>
                            </Dialog>
                        </Box>
                    </div>
                    : <div>
                        <Result
                            status="403"
                            title="403"
                            subTitle="Sorry, you are not authorized to access this page."
                            extra={<Button size="large" variant="outlined" href='project'>Back Home</Button>}
                        />
                    </div>
            }
        </div>
    );
    /**
     * <Dialog open={openDialog} onClose={handleClose}>
     *               <DialogTitle>Share</DialogTitle>
     *               <DialogContent dividers={true}>
     *                 <Typography variant="h6" sx={{pb: 2}}>
     *                   Share By Twitter
     *                 </Typography>
     *                 <TwitterShareButton
     *                     url={`${window.location.href}/${_.get(projectDetail, 'pid')}`}
     *                     options={{
     *                       size: 'large',
     *                       text: 'Apex - Food For All',
     *                     }}
     *                 />
     *               </DialogContent>
     *               <DialogContent>
     *                 <Typography variant="h6">
     *                   Share By Email
     *                 </Typography>
     *                 <DialogContentText>
     *                   Please input the email of the friend you want to share,
     *                   we will send the project information to your friend.
     *                 </DialogContentText>
     *                 <TextField
     *                     autoFocus
     *                     margin="dense"
     *                     id="name"
     *                     label="Email Address"
     *                     type="email"
     *                     fullWidth
     *                     variant="standard"
     *                 />
     *               </DialogContent>
     *               <DialogActions>
     *                 <Button onClick={handleClose}>Cancel</Button>
     *                 <Button onClick={handleClose} href='share'>Share</Button>
     *               </DialogActions>
     *             </Dialog>
     */
}
