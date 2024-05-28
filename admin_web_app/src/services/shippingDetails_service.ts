import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'



export interface SessionResultModeSeven {
    testId: string
    reading: SessionSevenReading
}

export interface SessionSevenReading {
    macAddress: string
    current: string
    voltage: string
    resistance: string
    result: string
    currentResult: string
    productionOrder: string
    readAt: string
}

export interface ShippingDetail {
    destination: string
    shipping_Id: string
    customer_PO: string
}

export interface Destination {
    destination: string
}

export interface Shipping_Id {
    shipping_Id: string
}

export interface Customer_PO {
    customer_PO: string
}


export const shippingDetailsApi = createApi({
    reducerPath: 'shippingDetailsApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'http://52.187.127.25/api/',
      
    }),
    tagTypes: ['shippingDetailList'],
    endpoints: (build) => ({
        getShippingDetails: build.query<ShippingDetail, {}>({
            query: () => `getAllShipping`,
            providesTags: [{ type: 'shippingDetailList', id: "getShippingDetails" }]

        }),
    }),
})

export const {
    useGetShippingDetailsQuery,
} = shippingDetailsApi