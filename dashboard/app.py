
import streamlit as st
import psycopg2
import pandas as pd

st.set_page_config(
    page_title="Hotel Booking Analytics",
    page_icon="🏨",
    layout="wide"
)

st.title("🏨 Hotel Booking & Cancellation Intelligence")
st.caption("Interactive Hotel Booking Analytics Dashboard")

# Database connection
st.sidebar.header("Database Connection")

db_password = st.sidebar.text_input(
    "PostgreSQL Password",
    type="password"
)

if db_password:

    try:
        connection = psycopg2.connect(
            host="localhost",
            port="5432",
            database="hotel_booking_analytics",
            user="postgres",
            password=db_password
        )

        df = pd.read_sql_query(
            "SELECT * FROM hotel_bookings",
            connection
        )

        connection.close()

        st.success("PostgreSQL connected successfully!")

        # Dashboard Filters
        st.sidebar.divider()
        st.sidebar.header("Dashboard Filters")

        hotels = sorted(df["hotel"].dropna().unique())

        selected_hotels = st.sidebar.multiselect(
            "Select Hotel",
            hotels,
            default=hotels
        )

        years = sorted(
            df["arrival_date_year"].dropna().unique()
        )

        selected_years = st.sidebar.multiselect(
            "Select Arrival Year",
            years,
            default=years
        )

        statuses = ["Canceled", "Not Canceled"]

        selected_status = st.sidebar.multiselect(
            "Booking Status",
            statuses,
            default=statuses
        )

        # Apply Filters
        filtered_df = df[
            (df["hotel"].isin(selected_hotels)) &
            (df["arrival_date_year"].isin(selected_years)) &
            (df["booking_status"].isin(selected_status))
        ].copy()

        if filtered_df.empty:
            st.warning("No bookings found for selected filters.")
            st.stop()

        # KPI Calculations
        total_bookings = len(filtered_df)

        cancellation_rate = (
            filtered_df["is_canceled"].mean() * 100
        )

        average_adr = filtered_df["adr"].mean()

        average_stay = filtered_df["total_nights"].mean()

        estimated_revenue = (
            filtered_df["estimated_revenue"].sum()
        )

        st.subheader("Business Performance Overview")

        col1, col2, col3, col4, col5 = st.columns(5)

        col1.metric("Total Bookings", f"{total_bookings:,}")
        col2.metric("Cancellation Rate", f"{cancellation_rate:.2f}%")
        col3.metric("Average ADR", f"€{average_adr:.2f}")
        col4.metric("Average Stay", f"{average_stay:.2f} nights")
        col5.metric("Estimated Revenue", f"€{estimated_revenue:,.0f}")

        st.divider()

        # Monthly Booking Trends
        st.subheader("📅 Monthly Booking Trends")

        month_order = [
            "January", "February", "March", "April",
            "May", "June", "July", "August",
            "September", "October", "November", "December"
        ]

        monthly = (
            filtered_df.groupby("arrival_date_month")
            .size()
            .reindex(month_order, fill_value=0)
            .reset_index(name="total_bookings")
        )

        st.bar_chart(
            monthly,
            x="arrival_date_month",
            y="total_bookings"
        )

        st.divider()

        # Hotel Performance
        st.subheader("🏨 Hotel Performance Comparison")

        hotel_data = (
            filtered_df.groupby("hotel")
            .size()
            .reset_index(name="total_bookings")
        )

        cancellation_data = (
            filtered_df.groupby("hotel")
            .agg(
                cancellation_rate=("is_canceled", "mean")
            )
            .reset_index()
        )

        cancellation_data["cancellation_rate"] *= 100

        col1, col2 = st.columns(2)

        with col1:
            st.markdown("**Bookings by Hotel**")
            st.bar_chart(
                hotel_data,
                x="hotel",
                y="total_bookings"
            )

        with col2:
            st.markdown("**Cancellation Rate by Hotel**")
            st.bar_chart(
                cancellation_data,
                x="hotel",
                y="cancellation_rate"
            )

        st.divider()

        # Market Segment Analysis
        st.subheader("📊 Cancellation Rate by Market Segment")

        market_data = (
            filtered_df.groupby("market_segment")
            .agg(
                total_bookings=("hotel", "size"),
                cancellation_rate=("is_canceled", "mean")
            )
            .reset_index()
        )

        market_data["cancellation_rate"] *= 100

        market_data = market_data.sort_values(
            "cancellation_rate",
            ascending=False
        )

        st.bar_chart(
            market_data,
            x="market_segment",
            y="cancellation_rate"
        )

        st.divider()

        # Customer Type Analysis
        st.subheader("👥 Customer Segmentation")

        customer_data = (
            filtered_df.groupby("customer_type")
            .agg(
                total_bookings=("hotel", "size"),
                cancellation_rate=("is_canceled", "mean")
            )
            .reset_index()
        )

        customer_data["cancellation_rate"] *= 100

        col1, col2 = st.columns(2)

        with col1:
            st.markdown("**Bookings by Customer Type**")
            st.bar_chart(
                customer_data,
                x="customer_type",
                y="total_bookings"
            )

        with col2:
            st.markdown("**Cancellation Rate by Customer Type**")
            st.bar_chart(
                customer_data,
                x="customer_type",
                y="cancellation_rate"
            )

        st.divider()

        # Country Analysis
        st.subheader("🌍 Top 10 Countries by Bookings")

        country_data = (
            filtered_df.dropna(subset=["country"])
            .groupby("country")
            .size()
            .reset_index(name="total_bookings")
            .sort_values(
                "total_bookings",
                ascending=False
            )
            .head(10)
        )

        st.bar_chart(
            country_data,
            x="country",
            y="total_bookings"
        )

        # Revenue Disclaimer
        st.divider()

        st.caption(
            "Revenue is estimated using ADR × total nights. "
            "It is not verified actual hotel revenue."
        )

    except Exception as error:
        st.error(f"Database connection failed: {error}")

else:
    st.info(
        "Enter your PostgreSQL password in the sidebar "
        "to load the dashboard."
    )
