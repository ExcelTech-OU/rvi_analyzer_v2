import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'

export interface StyleListResponse {
    status: string
    statusDescription: string
    styles: List<Style>
}

export interface Style {
    name: string
    plant: string
    customer: string
    admin: List<string>
    createdBy: string
    createdDateTime: string
}

export interface CommonResponse {
    status: string,
    statusDescription: string,
}

export interface StyleGetResponse {
    status: string,
    statusDescription: string,
    name: string
}

export const styleApi = createApi({
    reducerPath: 'styleApi',
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
    tagTypes: ['styleList'],
    endpoints: (build) => ({
        getStyle: build.query<StyleListResponse, {}>({
            query: () => `rvi/analyzer/v1/styles`,
            providesTags: [{ type: 'styleList', id: "getStyles" }]

        }),
        addStyle: build.mutation<StyleGetResponse, {}>({
            query(body) {
                return {
                    url: `register/style`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'styleList', id: "getStyles" }]
        }),
        deleteStyle: build.mutation<CommonResponse, { name: string }>({
            query(data) {
                return {
                    url: `delete/style/${data.name}`,
                    method: 'POST',
                    body: {},
                }
            },
            invalidatesTags: [{ type: 'styleList', id: "getStyles" }]
        }),
        allocateAdmin: build.mutation<StyleGetResponse, {}>({
            query(body) {
                return {
                    url: `/allocate/style/admin`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'styleList', id: "getStyles" }]
        }),
        allocateStyle: build.mutation<StyleGetResponse, {}>({
            query(body) {
                return {
                    url: `/allocate/style`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'styleList', id: "getStyles" }]
        }),
    }),
})

export const {
    useGetStyleQuery,
    useAddStyleMutation,
    useAllocateAdminMutation,
    useAllocateStyleMutation,
    useDeleteStyleMutation
} = styleApi