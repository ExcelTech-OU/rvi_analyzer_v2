import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'

export interface CustomerListResponse {
    status: string
    statusDescription: string
    customers: List<Customer>
}

export interface UserDeleteResponse {
    message: string,
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

export interface gtTrackingUser {
    user_name: string
    user_email: string
    password: string
}

export const gtTracking_userApi = createApi({
    reducerPath: 'gtTracking_userApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'http://52.187.127.25/api/',
        // prepareHeaders: (headers) => {
        //     const token = localStorage.getItem("jwt") as string;
        //     if (!headers.has("Authorization") && token) {
        //         headers.set("Authorization", `Bearer ${token}`);
        //     }
        //     return headers;
        // },
    }),
    tagTypes: ['gtTracking_userList'],
    endpoints: (build) => ({
        getGtTracking_user: build.query<gtTrackingUser, {}>({
            query: () => `getUsers`,
            providesTags: [{ type: 'gtTracking_userList', id: "gtTracking_users" }]

        }),
        deleteGtTracking_user: build.mutation<UserDeleteResponse, { user_email: string }>({
            query(data) {
                return {
                    url: `deleteUser/${data.user_email}`,
                    method: 'DELETE',
                    body: {},
                }
            },
            invalidatesTags: [{ type: 'gtTracking_userList', id: "gtTracking_users" }]
        }),
        addCustomer: build.mutation<CustomerGetResponse, {}>({
            query(body) {
                return {
                    url: `register/customer`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'gtTracking_userList', id: "getCustomers" }]
        }),
    }),
})

export const {
    useGetGtTracking_userQuery,
    useAddCustomerMutation,
    useDeleteGtTracking_userMutation
} = gtTracking_userApi