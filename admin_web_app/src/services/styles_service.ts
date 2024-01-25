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

export interface StyleGetResponse {
    status: string,
    statusDescription: string,
    name: string
}

export const styleApi = createApi({
    reducerPath: 'styleApi',
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
    }),
})

export const {
    useGetStyleQuery,
    useAddStyleMutation,
    useAllocateAdminMutation,
} = styleApi