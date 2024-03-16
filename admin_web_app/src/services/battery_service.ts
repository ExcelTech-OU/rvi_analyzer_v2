import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'


export interface BatteryResponse {
    status: string
    statusDescription: string
    batteries: List<Battery>
    total: number
}

export interface CommonResponse {
    status: string
    statusDescription: string
}

export interface Battery {
    _id: string
    admin: string
    plantName: string
    customerName: string
    styleOrderName: string
    soNumber: string
    poNumber: string
    batchNumber: string
    batteryHolderQrCode: string
    batteryHolderSoNumber: string
    batteryQrCode: string
    createdBy: string
    status: string
    createdDateTime: string
    lastUpdatedDateTime: string
}

export interface GetDashboardSummeryResponse {
    status: string
    statusDescription: string
    current: List<DateCount>
    past: List<DateCount>
    total: number
}

export interface DateCount {
    date: string
    count: string
}


export const batteryApi = createApi({
    reducerPath: 'batteryApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'https://smart-store.exceltch.com/smart-store-api/',
        // baseUrl: 'http://127.0.0.1:8900/',
        prepareHeaders: (headers) => {
            const token = localStorage.getItem("jwt") as string;
            if (!headers.has("Authorization") && token) {
                headers.set("Authorization", `Bearer ${token}`);
            }
            return headers;
        },
    }),
    tagTypes: ['battery'],
    endpoints: (build) => ({
        getBattery: build.query<BatteryResponse, { data: {}, page: number }>({
            query(data) {
                return {
                    url: `battery/get/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'battery', id: "getBattery" }]

        }),
        getAllBatteries: build.mutation<BatteryResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `battery/get/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'battery', id: "getBattery" }]
        }),
        getBatterySummery: build.query<GetDashboardSummeryResponse, { data: {} }>({
            query(data) {
                return {
                    url: `battery/get/summery/counts`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [
                { type: 'battery', id: "getDashboardSummary" }
            ]
        }),
        deleteBattery: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `battery/delete`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'battery', id: "getBattery" }]
        }),
        updateBattery: build.mutation<CommonResponse, { data: {} }>({
            query(data) {
                return {
                    url: `battery/update`,
                    method: 'POST',
                    body: { "data": data.data },
                }
            },
            invalidatesTags: [{ type: 'battery', id: "getBattery" }]
        }),
    }),
})

export const {
    useGetBatteryQuery,
    useGetAllBatteriesMutation,
    useGetBatterySummeryQuery,
    useDeleteBatteryMutation,
    useUpdateBatteryMutation
} = batteryApi