/**
 * @file share and payment success page
 * @author Mingze Ma
 */

// module import
import {} from 'react';

// style import
import './index.less';
import Box from "@mui/material/Box";
import Typography from '@mui/material/Typography';
import Button from "@mui/material/Button";
import * as React from "react";
import {Image} from "antd";
import success from 'src/modules/share/success.jpg'

export default (props) => {

  return (
    <div align="center">
      <Box align="center" textAlign="center"
           sx={{width: '100%', maxWidth: 500}}>
        <img src={success} alt="success" />
        <Typography variant="h3" component="div" gutterBottom>
          You have successfully shared it with your friends. Thank you for sharing.
        </Typography>

        <Button size="large" variant="outlined" href='project'>Confirm</Button>
      </Box>
    </div>
  );
}
