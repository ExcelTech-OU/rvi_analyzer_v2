import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'
import { CommonResponse } from './common_service'


export interface GetSingleMotorResponse {
    status: string
    statusDescription: string
    singleMotors: List<SingleMotor>
    total: number
}

export interface SingleMotor {
    _id: string
    dateCode: string
    current: string
    settingsCurrentMin: string
    settingsCurrentMax: string
    currentStatus: string
    noise: string
    settingsNoiseMin: string
    settingsNoiseMax: string
    noiseStatus: string
    createdBy: string
    createdDateTime: string
}

export interface GetMotorStackResponse {
    status: string
    statusDescription: string
    motorStacks: List<MotorStack>
    total: number
}

export interface MotorStack {
    _id: string
    dateCode: string
    current: string
    settingsCurrentMin: string
    settingsCurrentMax: string
    currentStatus: string
    voltage: string
    settingsVoltageMin: string
    settingsVoltageMax: string
    voltageStatus: string
    createdBy: string
    createdDateTime: string
}

export interface GetFullGarmentResponse {
    status: string
    statusDescription: string
    fullGarments: List<FullGarment>
    total: number
}

export interface GetELQCResponse {
    status: string
    statusDescription: string
    endLIneQcs: List<FullGarment>
    total: number,
    totalSuccess: number,
}

export interface GetAuditResponse {
    status: string
    statusDescription: string
    audits: List<FullGarment>
    total: number,
    totalSuccess: number,
}

export interface FullGarment {
    _id: string
    dateCode: string
    idleCurrent: string
    settingsIdleCurrentMin: string
    settingsIdleCurrentMax: string
    idleCurrentStatus: string
    flCurrent: string
    settingsFLCurrentMin: string
    settingsFLCurrentMax: string
    flCurrentStatus: string
    voltage: string
    noiseIdle: string
    settingsNoiseMin: string
    settingsNoiseMax: string
    noiseStatusIdle: string
    noiseFL: string
    noiseStatusFL: string
    createdBy: string
    soNumber: string
    productionOrder: string
    qrCode: string
    createdDateTime: string
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

export const softmatterApi = createApi({
    reducerPath: 'softmatterApi',
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
    tagTypes: ['softmatter'],
    endpoints: (build) => ({
        getSingleMotor: build.query<GetSingleMotorResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `softmatter/get/single/motor/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'softmatter', id: "getSingleMotor" }]

        }),
        getAllSingleMotor: build.mutation<GetSingleMotorResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `softmatter/get/single/motor/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'softmatter', id: "getSingleMotor" }]
        }),
        getMotorStack: build.query<GetMotorStackResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `softmatter/get/motor/stack/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'softmatter', id: "getMotorStack" }]

        }),
        getAllMotorStack: build.mutation<GetMotorStackResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `softmatter/get/motor/stack/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'softmatter', id: "getMotorStack" }]
        }),
        getFullGarment: build.query<GetFullGarmentResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `softmatter/get/full/garment/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'softmatter', id: "getFullGarment" }]

        }),
        getAllFullGarment: build.mutation<GetFullGarmentResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `softmatter/get/full/garment/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'softmatter', id: "getFullGarment" }]
        }),
        updateFullGarment: build.mutation<CommonResponse, { data: {} }>({
            query(data) {
                return {
                    url: `softmatter/update/full/garment`,
                    method: 'POST',
                    body: { "data": data.data },
                }
            },
            invalidatesTags: [{ type: 'softmatter', id: "getFullGarment" }]
        }),
        getELQC: build.query<GetELQCResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `softmatter/get/end/line/qc/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'softmatter', id: "getELQC" }]

        }),
        getAllELQC: build.mutation<GetELQCResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `softmatter/get/end/line/qc/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'softmatter', id: "getELQC" }]
        }),
        updateEndLineQC: build.mutation<CommonResponse, { data: {} }>({
            query(data) {
                return {
                    url: `softmatter/update/end/line/qc`,
                    method: 'POST',
                    body: { "data": data.data },
                }
            },
            invalidatesTags: [{ type: 'softmatter', id: "getELQC" }]
        }),
        getAudit: build.query<GetAuditResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `softmatter/get/audit/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'softmatter', id: "getAudit" }]

        }),
        getAllAudit: build.mutation<GetAuditResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `softmatter/get/audit/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'softmatter', id: "getAudit" }]
        }),
        updateAudit: build.mutation<CommonResponse, { data: {} }>({
            query(data) {
                return {
                    url: `softmatter/update/audit`,
                    method: 'POST',
                    body: { "data": data.data },
                }
            },
            invalidatesTags: [{ type: 'softmatter', id: "getAudit" }]
        }),
        getEndLineQcSummery: build.query<GetDashboardSummeryResponse, { data: {} }>({
            query(data) {
                return {
                    url: `softmatter/get/summery/counts/elqc`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [
                { type: 'softmatter', id: "getEndLineQcSummery" }
            ]
        }),
    }),
})

export const {
    useGetAllFullGarmentMutation,
    useGetAllMotorStackMutation,
    useGetAllSingleMotorMutation,
    useGetFullGarmentQuery,
    useGetMotorStackQuery,
    useGetSingleMotorQuery,
    useGetAllELQCMutation,
    useGetELQCQuery,
    useUpdateFullGarmentMutation,
    useUpdateEndLineQCMutation,
    useGetEndLineQcSummeryQuery,
    useGetAllAuditMutation,
    useGetAuditQuery,
    useUpdateAuditMutation
} = softmatterApi