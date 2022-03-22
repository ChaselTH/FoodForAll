/**
 * @file project actions
 * @author Mingze Ma
 */
import api from "src/api";
import apiConfig from "src/api/apiConfig";

export const getProjectList = params => api.get(apiConfig.projectList, params);
