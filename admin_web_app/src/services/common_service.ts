import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'


export interface ModeAdminsResponse {
    status: string
    statusDescription: string
    admins: List<AdminName>
    total: number
}

export interface AdminName {
    _id: string
    name: string
    createdBy: string
    status: string
    createdDateTime: string
    lastUpdatedDateTime: string
}

export interface PoNumberResponse {
    status: string
    statusDescription: string
    poNumbers: List<PoNumber>
    total: number
}

export interface PoNumber {
    _id: string
    name: string
    createdBy: string
    status: string
    createdDateTime: string
    lastUpdatedDateTime: string
}

export interface PlantResponse {
    status: string
    statusDescription: string
    plants: List<Plant>
    total: number
}

export interface Plant {
    _id: string
    name: string
    createdBy: string
    status: string
    createdDateTime: string
    lastUpdatedDateTime: string
}

export interface CustomerResponse {
    status: string
    statusDescription: string
    customers: List<Customer>
    total: number
}

export interface Customer {
    _id: string
    name: string
    createdBy: string
    status: string
    createdDateTime: string
    lastUpdatedDateTime: string
}

export interface DateCodesResponse {
    status: string
    statusDescription: string
    dateCodes: List<DateCode>
    total: number
}

export interface DateCode {
    _id: string
    name: string
    createdBy: string
    status: string
    createdDateTime: string
    lastUpdatedDateTime: string
}

export interface SendLocationsResponse {
    status: string
    statusDescription: string
    sendLocations: List<SendLocation>
    total: number
}

export interface SendLocation {
    _id: string
    name: string
    createdBy: string
    status: string
    createdDateTime: string
    lastUpdatedDateTime: string
}

export interface SoNumbersResponse {
    status: string
    statusDescription: string
    soNumbers: List<SoNumber>
    total: number
}

export interface SoNumber {
    _id: string
    name: string
    createdBy: string
    status: string
    createdDateTime: string
    lastUpdatedDateTime: string
}

export interface BatchNoResponse {
    status: string
    statusDescription: string
    batchNos: List<BatchNo>
    total: number
}

export interface BatchNo {
    _id: string
    name: string
    createdBy: string
    status: string
    createdDateTime: string
    lastUpdatedDateTime: string
}

export interface StyleOrderResponse {
    status: string
    statusDescription: string
    styleOrders: List<StyleOrder>
    total: number
}

export interface StyleOrder {
    _id: string
    name: string
    createdBy: string
    status: string
    createdDateTime: string
    lastUpdatedDateTime: string
}

export interface GeneralResponse {
    state: string
    stateDescription: string
}

export type GetSessionFilters = {
    type: string
    id: string
}

export type GetSessionQuestionsResponse = {
    questionAnswers: Map<string, string>
}

export type ShareReportResponse = {
    status: string
    statusDescription: string
    url: string
    password: string
}

export interface CommonResponse {
    status: string
    statusDescription: string
}

export const sessionApi = createApi({
    reducerPath: 'sessionApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'https://smart-store.exceltch.com/smart-store-api/',
        prepareHeaders: (headers) => {
            const token = localStorage.getItem("jwt") as string;
            if (!headers.has("Authorization") && token) {
                headers.set("Authorization", `Bearer ${token}`);
            }
            return headers;
        },
    }),
    tagTypes: ['commons'],
    endpoints: (build) => ({
        getAdmins: build.query<ModeAdminsResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/admin/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'commons', id: "getAdmins" }]

        }),
        addAdmin: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/save/admin`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getAdmins" }]
        }),
        deleteAdmin: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/delete/admin`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getAdmins" }]
        }),
        getAllAdmins: build.mutation<ModeAdminsResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/admin/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getAdmins" }]
        }),
        getPoNumber: build.query<PoNumberResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/po/numbers/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'commons', id: "getPoNumbers" }]

        }),
        addPoNumber: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/save/po/number`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getPoNumbers" }]
        }),
        deletePoNumber: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/delete/po/number`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getPoNumbers" }]
        }),
        getAllPoNumbers: build.mutation<PoNumberResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/po/numbers/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getPoNumbers" }]
        }),
        getPlants: build.query<PlantResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/plant/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'commons', id: "getPlants" }]

        }),
        addPlant: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/save/plant`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getPlants" }]
        }),
        deletePlant: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/delete/plant`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getPlants" }]
        }),
        getAllPlants: build.mutation<PlantResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/plant/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getPlants" }]
        }),
        getCustomer: build.query<CustomerResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/customer/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'commons', id: "getCustomers" }]

        }),
        addCustomer: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/save/customer`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getCustomers" }]
        }),
        deleteCustomer: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/delete/customer`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getCustomers" }]
        }),
        getAllCustomers: build.mutation<CustomerResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/customer/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getCustomers" }]
        }),
        getSoNumber: build.query<SoNumbersResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/soNumber/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'commons', id: "getSoNumbers" }]

        }),
        addSoNumber: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/save/soNumber`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getSoNumbers" }]
        }),
        deleteSoNumber: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/delete/soNumber`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getSoNumbers" }]
        }),
        getAllSoNumbers: build.mutation<SoNumbersResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/soNumber/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getSoNumbers" }]
        }),
        getBatchNo: build.query<BatchNoResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/batchNo/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'commons', id: "getBatchNos" }]

        }),
        addBatchNo: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/save/batchNo`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getBatchNos" }]
        }),
        deleteBatchNo: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/delete/batchNo`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getBatchNos" }]
        }),
        getAllBatchNos: build.mutation<BatchNoResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/batchNo/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getBatchNos" }]
        }),
        getStyleOrder: build.query<StyleOrderResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/styleOrder/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'commons', id: "getStyleOrders" }]

        }),
        addStyleOrder: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/save/styleOrder`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getStyleOrders" }]
        }),
        deleteStyleOrder: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/delete/styleOrder`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getStyleOrders" }]
        }),
        getAllStyleOrders: build.mutation<StyleOrderResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/styleOrder/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getStyleOrders" }]
        }),
        getDateCode: build.query<DateCodesResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/dateCode/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'commons', id: "getDateCode" }]

        }),
        addDateCode: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/save/dateCode`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getDateCode" }]
        }),
        deleteDateCode: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/delete/dateCode`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getDateCode" }]
        }),
        getAllDateCodes: build.mutation<DateCodesResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/dateCode/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getDateCode" }]
        }),
        getSendLocation: build.query<SendLocationsResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/send/location/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'commons', id: "getSendLocation" }]

        }),
        addSendLocation: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/save/send/location`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getSendLocation" }]
        }),
        deleteSendLocation: build.mutation<CommonResponse, {}>({
            query(body) {
                return {
                    url: `common/delete/send/location`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getSendLocation" }]
        }),
        getAllSendLocations: build.mutation<SendLocationsResponse, { data: {}, page: string }>({
            query(data) {
                return {
                    url: `common/get/send/location/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            invalidatesTags: [{ type: 'commons', id: "getSendLocation" }]
        }),
    }),
})

export const {
    useAddBatchNoMutation,
    useAddCustomerMutation,
    useAddPlantMutation,
    useAddSoNumberMutation,
    useAddStyleOrderMutation,
    useGetBatchNoQuery,
    useGetCustomerQuery,
    useGetPlantsQuery,
    useGetSoNumberQuery,
    useGetStyleOrderQuery,
    useGetAdminsQuery,
    useAddAdminMutation,
    useGetAllAdminsMutation,
    useGetAllBatchNosMutation,
    useGetAllCustomersMutation,
    useGetAllPlantsMutation,
    useGetAllSoNumbersMutation,
    useGetAllStyleOrdersMutation,
    useAddPoNumberMutation,
    useDeleteAdminMutation,
    useDeleteBatchNoMutation,
    useDeleteCustomerMutation,
    useDeletePlantMutation,
    useDeletePoNumberMutation,
    useDeleteSoNumberMutation,
    useDeleteStyleOrderMutation,
    useGetAllPoNumbersMutation,
    useGetPoNumberQuery,
    useAddDateCodeMutation,
    useDeleteDateCodeMutation,
    useGetAllDateCodesMutation,
    useGetDateCodeQuery,
    useAddSendLocationMutation,
    useDeleteSendLocationMutation,
    useGetAllSendLocationsMutation,
    useGetSendLocationQuery
} = sessionApi