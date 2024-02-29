import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'

export interface DashBoardSummaryResponse {
    status: string
    statusDescription: string
    modeOne: number
    modeTwo: number
    modeThree: number
    modeFour: number
    modeFive: number
    modeSix: number
    devices: number
    users: number
}

export const dashboardApi = createApi({
    reducerPath: 'dashboardApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'http://rvi.v2.exceltch.com/rvi-analyzer-api/',
        prepareHeaders: (headers) => {
            const token = localStorage.getItem("jwt") as string;
            if (!headers.has("Authorization") && token) {
                headers.set("Authorization", `Bearer ${token}`);
            }
            return headers;
        },
    }),
    tagTypes: ['dashboard'],
    endpoints: (build) => ({
        getDashboardSummary: build.query<DashBoardSummaryResponse, {}>({
            query: () => `rvi/analyzer/v1/get/dashboard`,
            providesTags: [
                { type: 'dashboard', id: "getDashboardSummary" }
            ]
        }),
    }),
})

export const {
    useGetDashboardSummaryQuery,
} = dashboardApi