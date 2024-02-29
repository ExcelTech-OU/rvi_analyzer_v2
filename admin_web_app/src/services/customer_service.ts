import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'

export interface CustomerListResponse {
    status: string
    statusDescription: string
    customers: List<Customer>
}

export interface CommonResponse {
    status: string,
    statusDescription: string,
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
        baseUrl: 'http://rvi.v2.exceltch.com/rvi-analyzer-api/',
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
        deleteCustomer: build.mutation<CommonResponse, { name: string }>({
            query(data) {
                return {
                    url: `delete/customer/${data.name}`,
                    method: 'POST',
                    body: {},
                }
            },
            invalidatesTags: [{ type: 'customerList', id: "getCustomers" }]
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
    useDeleteCustomerMutation
} = customerApi