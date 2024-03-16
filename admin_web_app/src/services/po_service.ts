import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'

export interface OrderListResponse {
    status: string
    statusDescription: string
    orders: List<Order>
}

export interface Order {
    soNumber: string
    orderId: string
    createdBy: string
    createdDateTime: string
}

export interface CommonResponse {
    status: string,
    statusDescription: string,
}

export const poApi = createApi({
    reducerPath: 'poApi',
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
    tagTypes: ['orderList'],
    endpoints: (build) => ({
        getPO: build.query<OrderListResponse, {}>({
            query: () => `rvi/analyzer/v1/productionOrders`,
            providesTags: [{ type: 'orderList', id: "getOrders" }]

        }),
    }),
})

export const {
    useGetPOQuery,
} = poApi