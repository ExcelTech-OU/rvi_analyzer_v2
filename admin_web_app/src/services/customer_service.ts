import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'
import { CommonResponse, GeneralResponse } from './device_service'
import { RolesResponse } from './login_service'

export interface CustomerListResponse {
    status: string
    statusDescription: string
    name: List<Customer>
}

export interface Customer {
    name: string
    plant: string
    createdBy: string
    createdDateTime: string
    lastUpdatedDateTime: boolean
}

export interface CustomerGetResponse {
    status: string,
    statusDescription: string,
    name: string
}

export const customerApi = createApi({
    reducerPath: 'customerApi',
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
    tagTypes: ['customerList'],
    endpoints: (build) => ({
        getCustomer: build.query<CustomerListResponse, {}>({
            query: () => `rvi/analyzer/v1/customers`,
            providesTags: [{ type: 'customerList', id: "getCustomers" }]

        }),
        addCustomer: build.mutation<CustomerGetResponse, {}>({
            query(body) {
                return {
                    url: `register/customer`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'customerList', id: "getCustomers" }]
        }),
    }),
})

export const {
    useGetCustomerQuery,
    useAddCustomerMutation,
} = customerApi