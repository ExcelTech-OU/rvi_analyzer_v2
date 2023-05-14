import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'

export interface DeviceListResponse {
    devices: List<Device>
}

export interface Device {
    id: string
    name: string
    macAddress: string
    batchNo: string
    firmwareVersion: string
    connectedNetworkId: string
    createdDate: string
    status: string
}

export interface GeneralResponse {
    state: string
    stateDescription: string
}

export interface CommonResponse {
    status: string
    statusDescription: string
}

export const deviceApi = createApi({
    reducerPath: 'deviceApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'http://127.0.0.1:7550/',
        prepareHeaders: (headers) => {
            const token = localStorage.getItem("jwt") as string;
            if (!headers.has("Authorization") && token) {
                headers.set("Authorization", `Bearer ${token}`);
            }
            return headers;
        },
    }),
    tagTypes: ['deviceList'],
    endpoints: (build) => ({
        getDevices: build.query<DeviceListResponse, {}>({
            query: () => `device/1/ACTIVE`,
            providesTags: [{ type: 'deviceList', id: "deviceListFetch" }]

        }),
        addDevice: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `device/add`,
                    method: 'POST',
                    body,
                }
            },
            invalidatesTags: [{ type: "deviceList", id: "deviceListFetch" }]
        }),
        updateDevice: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `device/update`,
                    method: 'POST',
                    body,
                }
            },
            invalidatesTags: [{ type: "deviceList", id: "deviceListFetch" }]
        }),
    }),
})

export const {
    useGetDevicesQuery,
    useAddDeviceMutation,
    useUpdateDeviceMutation
} = deviceApi