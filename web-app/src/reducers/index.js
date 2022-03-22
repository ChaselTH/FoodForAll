/**
 * @file reducer index
 * @author Mingze Ma
 */

import { combineReducers } from 'redux';

import user from './user';
import global from "./global";

export default combineReducers({
  user,
  global,
});
