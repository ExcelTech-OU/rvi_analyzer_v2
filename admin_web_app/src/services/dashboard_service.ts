import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'

export interface DashBoardSummaryResponse {
    numberOfDevices: string
    numberOfUsers: string
    numberOfSessions: string
    numberOfQuestions: string
}

export const dashboardApi = createApi({
    reducerPath: 'dashboardApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'http://18.136.146.172/achilles-api/',
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
            query: () => `device/dashboard`,
            providesTags: [
                { type: 'dashboard', id: "getDashboardSummary" }
            ]
        }),
    }),
})

export const {
    useGetDashboardSummaryQuery,
} = dashboardApi